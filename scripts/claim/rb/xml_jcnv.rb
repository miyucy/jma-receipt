#!/usr/bin/env ruby

# XMLfile j-code convert scirpt
#     args 0:in_file
#          1:out_code
# 
# version 1.3.0
#                  '01-10-30 by Yamamoto

require 'kconv'
require 'uconv'
in_file, out_code, mode = ARGV

#----- Define Classes ----------------------------------------

class XmlJCnv
  def initialize(fl,ocd,mode)
    @fpn = "" ; @fpn = String(fl)   if fl
    @to = ""  ; @to  = String(ocd)  if ocd
    @md = ""  ; @md  = String(mode) if mode
    @lct = 0
  end

  def argchk
    @arg = true
    if !File.exists?(@fpn)
      print " xmljcnv ERR: no file [ " + @fpn + " ]\n"
      @arg = false
    end
    case @to
    when "tou8"
      @out_code = "UTF-8"
    when "toeuc"
      @out_code = "EUC-JP"
    when "tosjis"
      @out_code = "Shift_JIS"
    when "tojis"
      @out_code = "JIS"
    else 
      @arg = false
    end
    case @md
    when "-n", "-normal", ""
      @md = "-n"
    when "-f", "-force"
      @md = "-f" 
    else
      @arg = false
    end
  end

  def chkhd
    case @head
    when /utf-8/i
      @in_code = "UTF-8"     ; @from = "u8"
    when /euc/i
      @in_code = "EUC-JP"    ; @from = "euc"
    when /shift_jis/i,/shift-jis/i
      @in_code = "(Shift_JIS|Shift-JIS)" ; @from = "sjis"
    when /jis/i
      @in_code = "JIS"       ; @from = "jis"
    else
#     @in_code = nil         ; @from = "" ; @to = ""
      @in_code = "UTF-8"     ; @from = "u8"
      @head = '<?xml version ="1.0" encoding="UTF-8" ?>'
	end
  end

  def ersub
    @ermes = "jcode unmatching at " + String(@lct) + " line"
    if @md == "-f"
      $stderr.print " xmljcnv Warrning:" + @ermes + "\n"
    else
      raise @ermes 
    end
  end

  def cvt
    open(@fpn,"rb") do |@f|
      @head = @f.gets ; chkhd ; @lct = 1
      @mes = "file:[" + @fpn + "] cmd:[" + @from + @to + "] mode:[" + @md + "]"
      $stderr.puts @mes
      @head.sub!(/#{@in_code}/i, @out_code) if @in_code
      puts @head 
      while @buf = @f.gets
        @lct += 1 ; @tp = Kconv::guess(@buf)
        case @from
        when "u8"
          ersub if !(@tp == 0 or @tp == 3)
          case @to
          when "tou8"
            print @buf
          when "toeuc"
            print Uconv::u8toeuc(@buf)
          when "tosjis"
            print Uconv::u8tosjis(@buf)
          when "tojis"
            @buf = Uconv::u8toeuc(@buf)
            print Kconv::tojis(@buf)
          end
        when "euc"
          ersub if !(@tp == 0 or @tp == 2)
          case @to
          when "tou8"
            print Uconv::euctou8(@buf)
          when "toeuc"
            print @buf
          when "tosjis"
            print Kconv::tosjis(@buf)
          when "tojis"
            print Kconv::tojis(@buf)
          end
        when "sjis"
          ersub if !(@tp == 0 or @tp == 3)
          case @to
          when "tou8"
            print Uconv::sjistou8(@buf)
          when "toeuc"
            print Kconv::toeuc(@buf)
          when "tosjis"
            print @buf
          when "tojis"
            print Kconv::tojis(@buf)
          end
        when "jis"
          ersub if !(@tp == 0 or @tp == 1)
          case @to
          when "tou8"
            @buf = Kconv::toeuc(@buf)
            print Uconv::euctou8(@buf)
          when "toeuc"
            print Kconv::toeuc(@buf)
          when "tosjis"
            print Kconv::tosjis(@buf)
          when "tojis"
            print @buf
          end
        else
          print @buf
        end
      end 
    end
  end

  def go
    argchk
    if !@arg
      puts "------------------------------------------------------"
      puts " Help:xmljcnv.rb in_xml_file"
      puts "                 out_code(tojis, toeuc, tosjis, tou8)"
      puts "                 mode(-n,nil=normal, -f=force)"
      puts "------------------------------------------------------"
    else
      begin
        cvt
      rescue
        @mes = " xmljcnv ERR:" + $!
        $stderr.puts @mes
      ensure
        "(nothing)"
      end
    end
  end
end

#----- Main --------------------------------------------------

hoe = XmlJCnv.new(in_file, out_code, mode)
hoe.go
