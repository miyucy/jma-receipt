#!/usr/bin/ruby

$:.unshift(File.dirname(__FILE__))

require "digest/md5"
require "orcadt_verify"

package_file = ARGV[0]  # ex. patch2.6.0.gz
save_dir = ARGV[1]+"/"  # ex. /var/lib/jma-receipt/patch/
package_url = ARGV[2]+"/"
offline = ARGV[3]	# ex. online or offline
cacert_file = ARGV[4]
obsolete = ARGV[5]      # ex. true or false
wgetoption = ARGV[6]	# ex. --passive-ftp

# 結果
# 0 : 正常
# 1 : エラー（ファイルが存在しない、wgetでエラーなど）

def caverify(url, opts)
   begin
     OrcaDT::Verifier.verify(url, opts)
   rescue Exception => ex
     puts "[ERROR] #{ex.message}"
     puts ex.backtrace
     return 1
   else
     return 0
   end
end

if File.exist?(save_dir+package_file)
   File.delete(save_dir+package_file)
end
if File.exist?(save_dir+package_file.gsub(/\.gz$/, ""))
   File.delete(save_dir+package_file.gsub(/\.gz$/, ""))
end

options = {}
options["do_verify"] = true
options["dir"] = "#{save_dir}"
options["cacert"] = "#{cacert_file}"

if offline == 'offline'
   if obsolete == 'yes'
      `cp #{package_url+package_file} #{save_dir}`
   else
      caverify("#{package_url+package_file+".p7m"}", options)
   end
   if $?.to_i > 0
      exit 1
   end
else
# ftp.orca.med.or.jp よりダウンロード
   if obsolete == 'yes'
      puts `wget -q #{wgetoption} -P #{save_dir} #{package_url+package_file}`
   else
      caverify("#{package_url+package_file+".p7m"}", options)
   end
   if $?.to_i > 0
      exit 1
   end
end
`gunzip -f #{save_dir+package_file}`
if $?.to_i > 0
   exit 1
end

tmp = open(save_dir+package_file.gsub(/\.gz$/, "")).read
tmp.each do |data|
   tmp1 = data.split(/,/)
   file = tmp1[0].to_s
   md5sum = tmp1[1].gsub(/\n/, "").to_s

   if File.exist?(save_dir+file)
      if md5sum != Digest::MD5.hexdigest(File.open(save_dir+file).read).to_s
	 File.delete(save_dir+file)
	 if offline == 'offline'
            if obsolete == 'yes'
	       `cp #{package_url+file} #{save_dir}`
            else
               caverify("#{package_url+file+".p7m"}", options)
            end
	    if $?.to_i > 0
	       exit 1
	    end
	 else
            if obsolete == 'yes'
	       `wget -q #{wgetoption} -P #{save_dir} #{package_url+file}`
            else
               caverify("#{package_url+file+".p7m"}", options)
            end
	    if $?.to_i > 0
	       exit 1
	    end
	 end
      end
   else
      if offline == 'offline'
         if obsolete == 'yes'
            `cp #{package_url+file} #{save_dir}`
         else
            caverify("#{package_url+file+".p7m"}", options)
         end
         if $?.to_i > 0
            exit 1
         end
      else
         if obsolete == 'yes'
            `wget -q #{wgetoption} -P #{save_dir} #{package_url+file}`
         else
            caverify("#{package_url+file+".p7m"}", options)
         end
	 if $?.to_i > 0
	    exit 1
	 end
      end
   end
end

exit 0
