#!/usr/bin/ruby

require "digest/md5"

package_file = ARGV[0]  # ex. patch2.6.0.gz
save_dir = ARGV[1]+"/"  # ex. /var/lib/jma-receipt/patch/
package_url = ARGV[2]+"/"
offline = ARGV[3]	# ex. online or offline
wgetoption = ARGV[4]	# ex. --passive-ftp

# 結果
# 0 : 正常
# 1 : エラー（ファイルが存在しない、wgetでエラーなど）

if File.exist?(save_dir+package_file)
   File.delete(save_dir+package_file)
end
if File.exist?(save_dir+package_file.gsub(/\.gz$/, ""))
   File.delete(save_dir+package_file.gsub(/\.gz$/, ""))
end

if offline == 'offline'
   `cp #{package_url+package_file} #{save_dir}`
   if $? > 0
      exit 1
   end
else
# ftp.orca.med.or.jp よりダウンロード
   `wget -q #{wgetoption} -P #{save_dir} #{package_url+package_file}`
   if $? > 0
      exit 1
   end
end
`gunzip -f #{save_dir+package_file}`
if $? > 0
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
	    `cp #{package_url+file} #{save_dir}`
	    if $? > 0
	       exit 1
	    end
	 else
	    `wget -q #{wgetoption} -P #{save_dir} #{package_url+file}`
	    if $? > 0
	       exit 1
	    end
	 end
      end
   else
      if offline == 'offline'
         `cp #{package_url+file} #{save_dir}`
	 if $? > 0
	    exit 1
	 end
      else
         `wget -q #{wgetoption} -P #{save_dir} #{package_url+file}`
	 if $? > 0
	    exit 1
	 end
      end
   end
end

exit 0
