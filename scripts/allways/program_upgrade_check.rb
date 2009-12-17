#!/usr/bin/ruby -Ke

require "digest/md5"

package_file = ARGV[0]  # ex. patch2.6.0.gz
save_dir = ARGV[1]+"/"  # ex. /var/lib/jma-receipt/patch/
prg_dir = ARGV[2]+"/"   # ex. /home/orca/orca-prg2.6.0/
patch_lib = "/usr/lib/jma-receipt/patch-lib"   # ex. /usr/lib/jma-receipt/patch-lib/
check_log_sh = "/usr/lib/jma-receipt/scripts/allways/program_upgrade_check_log.sh"

def localmd5_list(patch_lib)
  dir_list = []
  Dir.glob(patch_lib+"/**/*").each do |path|
    if FileTest.directory?(path)
    else
      dir_name = File.split(path)[0]
      file_name = File.split(path)[1]
      if file_name.to_s != ""
        unless file_name == "copying"
          begin
            md5 = Digest::MD5.hexdigest(File.open(path).read)
          rescue Exception => ex
            md5 = ""
          end
          dir_list.push([file_name, dir_name, md5])
        end
      end
    end
  end
  dir_list.sort!
  return dir_list
end

def make_relese_hash(prg_dir, patch_lib, md5_hash)
  tmp = open(prg_dir+"patch/ORCAPGC.DAT").read
  tmp.each do |data|
    data.chomp!
    module_ary = Array.new
    module_ary[0] = data[43..74].rstrip
    if data[77..140].rstrip == "."
      module_ary[1] = patch_lib
    else
      module_ary[1] = patch_lib+data[77..140].rstrip
      size = module_ary[1].size
      if module_ary[1][size-1,1] == "/"
        module_ary[1] = module_ary[1][0,size-1]
      end
    end
    module_ary[2] = ""
    if md5_hash[module_ary[0]] == nil
      md5_hash[module_ary[0]] = module_ary
    end
  end
  tmp = open(prg_dir+"patch/patch").read
  tmp.each do |data|
    data.chomp!
    data_ary = Array.new
    data_ary = data.split(",")
    if md5_hash[data_ary[0]] != nil
      module_ary = md5_hash[data_ary[0]]
      module_ary[2] = data_ary[1]
      md5_hash[module_ary[0]] = module_ary
    end
  end
end

#-- Main --

if File.exist?(save_dir+package_file)
  `gunzip -f #{save_dir+package_file}`
  if $?.to_i > 0
    exit 1
  end
end

md5_hash = Hash.new

if File.exist?(save_dir+package_file.gsub(/\.gz$/, ""))
  tmp = open(save_dir+package_file.gsub(/\.gz$/, "")).read
  tmp.each do |data|
    tmp1 = data.split(/,/)
    file = tmp1[0].to_s
    if File.exist?(save_dir+file)
      `tar zxf #{save_dir+file} -C #{prg_dir}`
      if $?.to_i > 0
        exit 1
      else
        `gunzip -f #{prg_dir}patch/patch.gz`
        if $?.to_i > 0
          exit 1
        end
        make_relese_hash(prg_dir, patch_lib, md5_hash)
      end
    end
  end
end

releasemd5_ary = md5_hash.values
localmd5_ary = localmd5_list(patch_lib)
releasemd5_ary.sort!
localmd5_ary.sort!

#puts "release list"
#p
#releasemd5_ary.each do |release|
#  p release
#end
#puts "local list"
#p
#localmd5_ary.each do |local|
#  p local
#end

`bash #{check_log_sh} clear`
if localmd5_ary == releasemd5_ary
  `bash #{check_log_sh} complete`
else
  localmd5_only_ary = localmd5_ary - releasemd5_ary
  releasemd5_only_ary = releasemd5_ary - localmd5_ary

  localmd5_only_ary.each do |local|
    only = 0
    releasemd5_only_ary.each do |release|
      if local[0] == release[0]
        only = 1
        if local[1] == release[1]
          if local[2] == release[2]
            `bash #{check_log_sh} error9 #{local[0]} #{local[1]}`
          else
            `bash #{check_log_sh} error3 #{local[0]} #{local[1]}`
          end
        else
          `bash #{check_log_sh} error4 #{local[0]} #{local[1]}`
        end
      end
    end
    if only == 0
      `bash #{check_log_sh} error2 #{local[0]} #{local[1]}`
    end
  end

  releasemd5_only_ary.each do |release|
    only = 0
    localmd5_only_ary.each do |local|
      if release[0] == local[0]
        only = 1
      end
    end
    if only == 0
      `bash #{check_log_sh} error1 #{release[0]} #{release[1]}`
    end
  end
end

exit 0
