#!/usr/bin/ruby

require 'find'

IGNORED_MODULES='ORCMCPSUB|MONFUNC|MCPSUB'


$all_modules=[]
$all_schemas=[]

$orca_schemas=[]
Find.find('./record') {|f|
	if  f=~/(tbl_|query_|view_)(.*).db$/
	   $orca_schemas.push(($1 + $2).upcase)  
	end
}

$path_type1=[]
$orca_schemas.each {|x|
	if x=~/(TBL_|VIEW_|)(.*)/
		$path_type1.push((" \\\"" + $2 + "-.*\\\""))
	end
}
	
$path_type2=[]
$orca_schemas.each{|x|
	if x=~ /(TBL_|VIEW_|QUERY_)(.*)/
		$path_type2.push(('PATH-' + $1 + $2 + '-').gsub(/_/,'-'))
	end
}

$path_type3=[]
$orca_schemas.each{|x|
	$path_type3.push(("\"" + x.downcase + "\""))
}


def analyze_module(name,file)
	lines=file.readlines
	i=0
	lines.each{|x|
	    if x=~/PROCEDURE .*DIVISION.*/
	    	break;
	    end
	    i+=1
	}
	lines=lines.slice(i..(lines.size - 1))
	lines.delete_if{|x| /^......\*/=~x}
	modules=[]
	schemas=[]
	lines.each{|x|
	    if x=~/.* CALL .*\"(.*)\".*/
			modules.push($1)
	    end

	    $path_type1.each_index{|i|
	    	if x=~/#{$path_type1[i]}/
				schemas.push($orca_schemas[i])
	    	end
	    }

	    $path_type2.each_index{|i|
	    	if x=~/#{$path_type2[i]}/
				schemas.push($orca_schemas[i])
	    	end
	    }

	    $path_type3.each_index{|i|
	    	if x=~/#{$path_type3[i]}/
				schemas.push($orca_schemas[i])
	    	end
	    }
	}

	modules.uniq!
	schemas.uniq!

	puts name

	if modules.size > 0
		puts "-- " + modules.size.to_s + " modules --"
		puts modules
	end
	if schemas.size > 0
		puts "-- " + schemas.size.to_s + " schemas --"
		puts schemas
	end

	modules.each {|m|
		if ($all_modules.index(m) == nil && IGNORED_MODULES.split(/\|/).index(m) == nil)
			Find.find('./cobol') {|f|
				if  f=~/#{m}.CBL$/
					File.open(f){|y|
						fname = name + '->' + m
						analyze_module(fname,y)
					}
				end
			}
		else
			puts name + '->' + m
			puts "(skip)"
		end
	}
	$all_modules.concat(modules)
	$all_schemas.concat(schemas)
end

def main

	while argv = ARGV.shift
		if  argv=~/.CBL$/
			File.open(argv){|y|
				analyze_module(argv,y)
			}
		end
	end
	$all_modules.uniq!
	$all_schemas.uniq!
	puts ""
	puts ""
	puts "** all modules (" + $all_modules.size.to_s + " modules)  **"
	puts $all_modules
	puts ""
	puts "** all schemas (" + $all_schemas.size.to_s + " schemas) **"
	puts $all_schemas
end

main
