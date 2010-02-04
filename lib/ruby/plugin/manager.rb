require "yaml"
require "fileutils"
require "tempfile"
require "logger"
require "open-uri"
require "plugin"
require "plugin/db"
require "plugin/store"
require "plugin/util"

module JMA::Plugin
  class Manager
    def initialize(config)
      raise "root not specified" unless config[:root]
      raise "list not specified" unless config[:list]
      defaultlog = Logger.new(STDOUT)
      defaultlog.level = Logger::INFO
      @log = config[:log] || defaultlog
      @config = config
      @store = JMA::Plugin::Store.new(@config)
      @db = JMA::Plugin::DB.new(File.join(@config[:root],"package.db"))
    end

    def update
      lock {
        @config[:list].each{|url|
          begin
            @log.info("get package info from #{url}")
            plist = YAML.load(download_list(url))
            plist.each{|control|
              same_name_list = @db.list.select{|c|  c[:name] == control[:name]}
              upper_list = same_name_list.select{|c| c[:version] >= control[:version]}
              if upper_list.empty?
                @log.info("new package:#{control[:name]}-#{control[:version]}")
                @db.insert(control)
                same_name_list.each{|c| 
                  if c[:install] == "FALSE"
                    @log.info("delete old package:#{c[:name]}-#{c[:version]}")
                    @db.delete(c[:name],c[:version])
                  end
                }
              end
            }
          rescue Exception => ex
            @log.error("can not get package info:#{url} #{ex}")
            raise ex
          end
        } 
      }
    end

    def install(name,version)
      lock {
        @log.info("install #{name}-#{version}")
        _install(name,version)
      }
    end

    def uninstall(name,version)
      lock {
        @log.info("uninstall #{name}-#{version}")
        _uninstall(name,version)
      }
    end

    def link(name,version)
      lock {
        @log.info("link #{name}-#{version}")
        _link(name,version)
      }
    end

    def unlink(name,version)
      lock {
        @log.info("unlink #{name}-#{version}")
        _unlink(name,version)
      }
    end

    def upgrade
      lock {
        @log.info("upgrade")
        list_upgrade.each{|c|
          begin
            new = c[:new]
            old = c[:old]
            @log.info("upgrade #{old[:name]}-#{old[:version]} to #{new[:name]}-#{new[:version]} ...")
            _install(new[:name],new[:version])
            @db.delete(old[:name],old[:version])
          rescue Exception => ex
            raise ex
          end
        }
      }
    end

    def list_upgrade
      upgradable = []
      all = @db.list
      @db.list_installed.each{ |control|
        candidate = all.select{|c| 
          c[:install] == "FALSE" && 
          c[:name] == control[:name] && 
          c[:version] > control[:version]
        }
        unless candidate.empty?
          candidate.sort!{|a,b| a[:version] <=> b[:version]} # asending order
          upgradable << {:new => candidate[-1], :old => control}
        end
      }
      return upgradable
    end

    def list(type="all")
      case type
      when "install"
        return @db.list_installed
      when "enable"
        return @db.list_linked
      when "upgrade"
        return list_upgrade
      else
        return @db.list
      end
    end

    def search(name)
      @db.list.select{|c| c[:name].index(name)}
    end

    def clean_cache
      @store.clean_cache
    end

    def info(name, version)
      ret = {}
      control = @db.get_control(name,version)
      raise "#{name}-#{version} is not in the list " unless control
      ret[:control] = control
      ret[:file] = @store.list_file(name,version) if control[:install] == "TRUE"
      ret[:link] = @store.list_link(name,version) if control[:link] == "TRUE"
      return ret
    end

    private

    def _install(name,version)
      control = @db.get_control(name,version)
      unless control
        raise "#{name}-#{version} is not in the list"
      end
      if @db.install?(name,version)
        raise "#{name}-#{version} already installed" 
      end
      upper = @db.list_installed.select{|c| 
        c[:name] == name &&
        c[:version] > version
      }
      unless upper.empty?
        @log.info("#{name}-#{upper[0][:version]} installed")
        return 
      end
      package_path = download_package(control[:name],control[:version],control[:url])
      old = @db.list_installed.select{|c| c[:name] == name}
      do_link = false
      unless old.empty?
        old.each {|o|
          @log.info("uninstall old version ... #{o[:name]}-#{o[:version]}")
          _uninstall(o[:name],o[:version]) #rescue nil
          do_link = o[:link] == "TRUE"
        }
      end
      @store.install(name,version,package_path)
      @db.install(name,version)
      _link(name,version) if do_link
    end

    def _uninstall(name,version)
      control = @db.get_control(name,version)
      unless control
        raise "#{name}-#{version} is not in the list"
      end
      unless @db.install?(name,version)
        raise "#{name}-#{version} does not installed"
      end
      @store.unlink(name,version) rescue nil
      @store.uninstall(name,version)
      @db.unlink(name,version) if @db.link?(name,version)
      @db.uninstall(name,version)
    end

    def _link(name,version)
      control = @db.get_control(name,version)
      unless control
        raise "#{name}-#{version} is not in the list"
      end
      unless @db.install?(name,version)
        raise "#{name}-#{version} does not installed"
      end
      if @db.link?(name,version)
        raise "#{name}-#{version} already linked"
      end
      @store.link(name,version)
      @db.link(name,version)
    end

    def _unlink(name, version)
      control = @db.get_control(name,version)
      unless control
        raise "#{name}-#{version} is not in the list"
      end
      unless @db.install?(name,version)
        raise "#{name}-#{version} does not installed"
      end
      unless @db.link?(name,version)
        raise "#{name}-#{version} does not linked"
      end
      @store.unlink(name,version)
      @db.unlink(name,version)
    end

    def lock
      path = File.join(Dir.tmpdir,".jma_plugin_lock")
      lock_file = open(path, File::RDWR|File::CREAT)
      begin
        lock_file.flock(File::LOCK_EX)
        yield
      rescue Exception => ex
        @log.error("error:#{ex}")
        #puts ex.backtrace
        raise ex
      ensure
        lock_file.close
        FileUtils.rm_f(path)
      end
    end

    def download(url)
      data = nil
      begin
        data = File.read(url)
      rescue Errno::ENOENT
        OpenURI.open_uri(url) {|io| data = io.read }
      end 
      return data
    end

    def download_package(name,version,url)
      pkg_data = download(url)
      pkg = @store.create_cache_file("#{name}-#{version}.jpp",pkg_data)
      if @config[:verify]
        sign_data = download(url + ".asc")
        sign = @store.create_cache_file("#{name}-#{version}.jpp.asc",sign_data)
        JMA::Plugin::Util::verify_sign(sign)
      end
      return pkg
    end

    def download_list(url)
      list_data = download(url)
      if @config[:verify]
        list = Tempfile.new("jma_plugin_list",Dir.tmpdir)
        list.write(list_data)
        list.close
        sign = list.path + ".asc"
        begin
          sign_data = download(url + ".asc")
          File.open(sign,"w"){ |io| io.write(sign_data) }
          JMA::Plugin::Util::verify_sign(sign)
        ensure
          FileUtils.rm_f(sign)
          list.close(true)
        end
      end
      return list_data
    end

  end
end
