#! /bin/sh
#/bin/sh -F
	if	[ $1 = 'red2ps' ]	;then
		if	[ $# -eq 5 ]	;then
			$1 $2 $4 -p $5
		else
			$1 $2 $4 -p lp1
		fi
	else	
		ruby $1 $2 $3 $4 $5
	fi
#----------------------------------------------------------------------#
#	ファイル削除処理
#----------------------------------------------------------------------#
HCLIST="HC04 HC08 HC18 HC20 HC21 HC22 HC23 HC24"
  for FL in $HCLIST
  do
	if	[ $FL = ${4:9:4} ]	;then
                 echo ${4:9:4}
		exit
	fi
  done
  if [ -e $4 ]	;then
        echo $4
	rm $4
  fi
#----------------------------------------------------------------------#
#	終了処理
#----------------------------------------------------------------------#
	echo "The end"
exit $RET
