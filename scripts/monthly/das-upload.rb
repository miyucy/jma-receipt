#! /usr/bin/ruby

$:.unshift(File.dirname(__FILE__) + "/lib")

require "uri"
require "net/https"
require "digest/sha1"

require "orcadas/formdata"
require "orcadas/utils"

module OrcaDAS
  class Command
    def initialize()
      @config = self.load_config
      if @config.nil? || @config.length <= 0 || @config["Host"].nil?
        raise "101 config failure"
      end
    end

    def http_request(url, http_method, header, body, config)
      parsed_url = URI.parse(url)
      http = Net::HTTP.new(parsed_url.host, parsed_url.port)
      
      case parsed_url.scheme
      when "https"
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        if config["CertificateCAFile"]
          http.ca_file = File.expand_path(config["CertificateCAFile"])
        end
      when "http"
        # do nothing
      else
        raise "unexpected URI scheme: #{parsed_url.scheme}"
        return false
      end

      req = case http_method
            when :POST then Net::HTTP::Post.new(parsed_url.path, header)
            when :GET  then Net::HTTP::Get.new(parsed_url.path, header)
            else raise "001 unexpected HTTP method: #{http_method}"
            end

      req["user-agent"] = "#{USER_AGENT}/#{PGVERSION} (#{PGRELDATE})"
      req.basic_auth(config["User"], config["Password"])
      res = http.request(req, body)
      yield(res)
    end

    def http_get(url, header, config=@config, &block)
      http_request(url, :GET, header, nil, config, &block)
    end

    def http_post(url, header, body, config=@config, &block)
      http_request(url, :POST, header, body, config, &block)
    end

    def upload(filename, config=@config)
      url = config["Host"] + config["Path"]
      formdata = OrcaDAS::FormData.new
      data = File.open(filename).read
      formdata.add_data(data, filename)
      http_post(url, formdata.header, formdata.body, config){ |res|
        if res.code.to_i != 200
          raise res.code + " " + res.msg
        end
      }
      $stdout.puts "UP #{filename}"
      return true
    end

    def server_check(config=@config)
      url = config["Host"] + "/"
      http_get(url, nil, config){ |res|
        if res.code.to_i != 200
          return false
        end
      }
      $stdout.puts "OK"
      return true
    end

    def run(filename, config=@config)
      return upload(filename, config)
    end

    def self.main(argv)
      begin
        das = self.new
        if argv.length <= 0
          $stderr.puts "das-upload.rb $file"
          exit 1
        end
        opt = argv.shift
        if opt == "-c"
          exit(das.server_check ? 0 : 1)          
        else
          exit(das.run(opt) ? 0 : 1)
        end
      rescue => ex
        if /^[0-9][0-9][0-9]/ =~ ex.message
            $stderr.puts "#{ex.message} (#{ex.class.name})"
        else
            $stderr.puts "999 #{ex.message} (#{ex.class.name})"
        end
      end
    end
  end
end

CLIENT_CONFIG_FILE = ENV['CLIENT_CONFIG_FILE']
OrcaDAS::Command.main(ARGV) if $0 == __FILE__
