#!/usr/bin/ruby -Ke

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
if ARGV.size == 5
  $printer = ARGV[4]
else
  $printer = "lp1"   
end
puts "ARG4= [" + $printer + "]"

$red_file = ARGV[0]
$in_file = ARGV[1]
p_const = ARGV[2]
$printer = ARGV[3]
o_const = ARGV[4]
$output_ps = ARGV[5]

puts "ARG1= [" + $red_file + "]"
puts "ARG2= [" + $in_file + "]"
puts "ARG3= [" + p_const + "]"
puts "ARG4= [" + $printer + "]"
puts "ARG5= [" + o_const + "]"
puts "ARG6= [" + $output_ps + "]"


if $output_ps
  system(RED2PS, $red_file, $in_file, "-o", $output_ps)
  if $printer != "----------"
puts "print start"
  	system(LPR, "-P", $printer, $output_ps)
#  	system(LPR, "-P", $printer, $output_ps.path)
  end
end
