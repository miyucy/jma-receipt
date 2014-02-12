#!/usr/bin/ruby 
# coding : euc-jp
Encoding.default_external = "euc-jp"

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
