#!/usr/bin/env sh
#----------------------------------------------------------------------#
#       引数	
#       1:DATAファイル名称
#----------------------------------------------------------------------#

	echo	`date`
	echo	$1

ruby /usr/local/orca/scripts/daily/print_parent2.rb "temp.tmp" "ruby /usr/local/orca/scripts/daily/print-data.rb " $1 

	rm -f $1
	echo	`date`
