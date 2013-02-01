#!/usr/bin/ruby 

require 'nkf'

$KCODE="EUC"

CODES = {
  NKF::EUC      => "EUC",
}

STDIN.read.each{|l|
  l.split(//).each{|c|
    if CODES[ NKF.guess(c) ] == "EUC"
      print "¢¢"
    else
      print c
    end
  }
}
