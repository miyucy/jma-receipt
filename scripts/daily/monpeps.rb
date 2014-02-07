#!/usr/bin/ruby
# coding : utf-8

require 'fileutils'

module MONPEPS

  module_function

  def merge_ps(distfname,list)
    return if list.empty?
    File.open(distfname,"w") {|io|
      pagenum = 0
      list.each{|fname|
        psdata = File.read(fname)
        psdata.gsub!(%r!^%%Page:\s+\d+\s+\d+!){
          pagenum += 1
          %!%%Page: #{pagenum} #{pagenum}!
        }
        io.print(psdata)
      }
    }
  end
end

if __FILE__ == $0
  MONPEPS::merge_ps("merged.ps",ARGV)
end
