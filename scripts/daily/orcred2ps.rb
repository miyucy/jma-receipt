#!/usr/bin/ruby -Ke
# coding : euc-jp
Encoding.default_external = "euc-jp"

#require "getoptlong"
#require "tempfile"
#require "fold"
#require "dia/parser"

puts "¡ú¡ú¡ú¡ú orcred2ps start "
RED2PS = "red2ps"
LPR = "lpr"

if ARGV.size < 4
  usage
  exit 1
end
if ARGV.size == 9
  $printer = ARGV[7]
else
  $printer = "lp1"   
end
puts "ARG7= [" + $printer + "]"

$red_file = ARGV[0]
$in_file = ARGV[1]
x_const = ARGV[2]
$offset_x = ARGV[3]
y_const = ARGV[4]
$offset_y = ARGV[5]
p_const = ARGV[6]
$printer = ARGV[7]
o_const = ARGV[8]
$output_ps = ARGV[9]

puts "ARG1= [" + $red_file + "]"
puts "ARG2= [" + $in_file + "]"
puts "ARG3= [" + x_const + "]"
puts "ARG4= [" + $offset_x + "]"
puts "ARG5= [" + y_const + "]"
puts "ARG6= [" + $offset_y + "]"
puts "ARG7= [" + p_const + "]"
puts "ARG8= [" + $printer + "]"
puts "ARG9= [" + o_const + "]"
puts "ARG10= [" + $output_ps + "]"


if $output_ps
  system(RED2PS, $red_file, $in_file, "-x", $offset_x, "-y", $offset_y, "-o", $output_ps)
  if $printer != "----------"
puts "print start"
  	system(LPR, "-P", $printer, $output_ps)
#  	system(LPR, "-P", $printer, $output_ps.path)
  end
end
