#!/usr/bin/env sh

	echo	`date`
	echo	$1
	echo	$2
	echo	$3
	echo	$4
	echo	$5

ruby /usr/local/orca/scripts/daily/print_parent.rb "temp.tmp" "ruby /usr/local/orca/scripts/daily/print-data.rb " $1 $2 $3 $4 $5

	echo	`date`
