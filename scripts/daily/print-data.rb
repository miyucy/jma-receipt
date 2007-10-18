#!/usr/bin/ruby -Ke

require "getoptlong"
require "tempfile"
require "fold"
require "dia/parser"

DIA = "dia-orca"
LPR = "lpr"

class DataTranslator < Dia::Parser
  HAN2ZEN = {
    "0" => "��",
    "1" => "��",
    "2" => "��",
    "3" => "��",
    "4" => "��",
    "5" => "��",
    "6" => "��",
    "7" => "��",
    "8" => "��",
    "9" => "��",
    "A" => "��",
    "B" => "��",
    "C" => "��",
    "D" => "��",
    "E" => "��",
    "F" => "��",
    "G" => "��",
    "H" => "��",
    "I" => "��",
    "J" => "��",
    "K" => "��",
    "L" => "��",
    "M" => "��",
    "N" => "��",
    "O" => "��",
    "P" => "��",
    "Q" => "��",
    "R" => "��",
    "S" => "��",
    "T" => "��",
    "U" => "��",
    "V" => "��",
    "W" => "��",
    "X" => "��",
    "Y" => "��",
    "Z" => "��",
    "a" => "��",
    "b" => "��",
    "c" => "��",
    "d" => "��",
    "e" => "��",
    "f" => "��",
    "g" => "��",
    "h" => "��",
    "i" => "��",
    "j" => "��",
    "k" => "��",
    "l" => "��",
    "m" => "��",
    "n" => "��",
    "o" => "��",
    "p" => "��",
    "q" => "��",
    "r" => "��",
    "s" => "��",
    "t" => "��",
    "u" => "��",
    "v" => "��",
    "w" => "��",
    "x" => "��",
    "y" => "��",
    "z" => "��",
    "," => "��",
    "." => "��"
  }
  
  def translate(xml, data, out)
    @out = out
    @data = data
    @no_output = false
    parse(xml)
  end

  META_CHARS = {
    "&" => "&amp;",
    "<" => "&lt;",
    ">" => "&gt;",
    "'" => "&apos;",
    "\"" => "&quot;",
  }

  def escape(s)
    str = s.dup
    str.gsub!(/[&<>'"]/) { |s| META_CHARS[s] }
    #str.gsub!(/[\x80-\xff]/) { |s| "&#" + s[0].to_s + ";" }
    return str
  end

  def startElement(name, attrs)
    super(name, attrs)
    attr = ''
    attrs.each do |key, val|
      attr.concat(" #{key}=\"#{escape(Uconv.u8toeuc(val))}\"")
    end
    @out.print("<#{name}#{attr}>")
    if @in_orca_text &&
	@obj_attrs.key?("orca_id") &&
	name == "string" &&
	@obj_attr_stack[-1] == "string"
      @no_output = true
    elsif @in_embed_image &&
      @obj_attr_stack[-1] == "file"
      @no_output = true
    end
  end

  def endElement(name)
    super
    if @in_orca_text && @no_output && name == "string"
      text = @data[@obj_attrs["orca_id"]]
      unless text
	raise "no data"
      end
      @out.print("#" + format_text(text) + "#")
      @no_output = false
    elsif @in_embed_image && @no_output && name == "string"
      text = @data[@obj_attrs["file"]]
      unless text
  	raise "no data"
      end
      @out.print("#" + escape(text) + "#")
      @no_output = false
    end
    @out.print("</#{name}>")
  end

  def character(data)
    super
    unless @no_output
      @out.print(escape(Uconv.u8toeuc(data)))
    end
  end

  def default(data)
    @out.print(data)
  end

  def han2zen(s)
    return s.gsub(/[0-9A-Za-z,.]/) { |s| HAN2ZEN[s] }
  end

  def format_text(s)
    column = @obj_attrs["orca_column"]
    if column
      s = s.fold(column)
    end
    unless @obj_attrs["orca_hankaku"]
      s = han2zen(s)
      s = escape(s)
      s = s.gsub(/[\x80-\xff]/) { |s| "&#" + s[0].to_s + ";" }
    else
      s = escape(s)
    end

    return s
  end
end

def usage
  $stderr.printf(<<EOF, $0)
usage: %s [-o output.ps] <dia file> <def file> <data file> [printer]
EOF
end

$output_ps = nil
$printer = nil

parser = GetoptLong.new
parser.set_options(['-o', GetoptLong::REQUIRED_ARGUMENT],
		   ['--help', '-h', GetoptLong::NO_ARGUMENT])

begin
  parser.each_option do |name, arg|
    case name
    when "-o"
      $output_ps = arg
    when "--help"
      usage
      exit
    end
  end
rescue
  usage
  exit(1)
end

if ARGV.size < 3
  usage
  exit 1
end
if ARGV.size == 4
  $printer = ARGV[3]
else
  $printer = "lp1"   
end

dia_file = open(ARGV.shift)
def_file = open(ARGV.shift)
data_file = open(ARGV.shift)

data = {}

while line = def_file.gets
  orca_id, orca_type, orca_size = line.split(/,/, 3)
  size = orca_size.to_i
  if size > 0
    if orca_type == "I"
      data[orca_id] = data_file.read(orca_size.to_i).gsub(/\0/, "").strip
    else
      data[orca_id] = data_file.read(orca_size.to_i).gsub(/\0/, "")
    end
  end
end

xml_file = Tempfile.new("dia-xml")
xml = dia_file.read
dt = DataTranslator.new
dt.translate(xml, data, xml_file)
xml_file.close

if $output_ps
  system(DIA, "-p", $output_ps, xml_file.path)
else
  ps_file = Tempfile.new("dia-ps")
  ps_file.close
  system(DIA, "-p", ps_file.path, xml_file.path)
  system(LPR, "-P", $printer, ps_file.path)
end
