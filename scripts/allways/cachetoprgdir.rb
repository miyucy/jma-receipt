#!/usr/bin/ruby

package_file = ARGV[0]  # ex. patch2.6.0.gz
save_dir = ARGV[1]+"/"  # ex. /var/lib/jma-receipt/patch/
prg_dir = ARGV[2]+"/"   # ex. /home/orca/orca-prg2.6.0/

if File.exist?(save_dir+package_file)
   `gunzip -f #{save_dir+package_file}`
   if $? > 0
      exit 1
   end
end
if File.exist?(save_dir+package_file.gsub(/\.gz$/, ""))
   tmp = open(save_dir+package_file.gsub(/\.gz$/, "")).read
   tmp.each do |data|
      tmp1 = data.split(/,/)
      file = tmp1[0].to_s

      if File.exist?(save_dir+file)
        `tar zxf #{save_dir+file} -C #{prg_dir}`
	if $? > 0
	   exit 1
	else
	   `mv #{prg_dir}/patch/* #{prg_dir}`
	   if $? > 0
	      exit 1
	   else
	      `rmdir #{prg_dir}/patch`
	      if $? > 0
	         exit 1
	      end
	   end
	end
      end
   end
end

exit 0
