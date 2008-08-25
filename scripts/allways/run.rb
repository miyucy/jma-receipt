#!/usr/bin/ruby1.8
require 'date'

ENV['PATH'] = "/sbin:/bin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

list = `psql orca -At -F ',' -c 'SELECT DOW,MON,DOM,HOUR,SCRIPT from tbl_cron where RUN = \'1\'\;'`.split("\n").map{|r|
  r = r.split(/,/).map{|c| c = "." * c.length if c =~ /^\*/; c }
  [sprintf("%s %s/%s/.. %s", r[0], r[1], r[2], r[3]), r[4..-1].join(" ")] 
}

time = DateTime.now.strftime("%w %D %H")

list.each { |cmd|
  next unless /#{cmd[0]}/ =~ time
  open("/tmp/jma-receipt-cron-lock", "w"){|f| f.flock(File::LOCK_EX); puts `#{cmd[1]}`; f.flock(File::LOCK_UN) }
}

