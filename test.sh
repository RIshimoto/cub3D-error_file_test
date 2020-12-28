#!/bin/bash

path="./cub3D"
see_the_error_message=false
memory_leak_check=true
ESC=$(printf '\033')
all=0
ac=0
tmpfile=$(mktemp)
for f in ./${1:-*}/*; do
	all=$(( $all + 1 ))
	$path $f 2> $$
	if [ ${f%/*} = "./Accept" ]; then 
		if [ ! -s $$ ]; then
			ac=$(( $ac + 1 ))
			printf "%-50s%c${ESC}[32m%s${ESC}[m%c" $f '[' 'OK' ']';
		else
			printf "%-50s%c${ESC}[31m%s${ESC}[m%c" $f '[' 'Fail' ']';
		fi
	else
		if [ -s $$ ]; then
			ac=$(( $ac + 1 ))
			printf "%-50s%c${ESC}[32m%s${ESC}[m%c" $f '[' 'OK' ']';
		else
			printf "%-50s%c${ESC}[31m%s${ESC}[m%c" $f '[' 'Fail' ']';
		fi
	fi
	if  $memory_leak_check ; then
		valgrind --leak-check=full $path $f 2>$tmpfile
		memoryleak=`tail -1 $tmpfile | awk '{print $4}'`
		if [ $memoryleak != 0 ]; then
			printf "%c${ESC}[31m%s${ESC}[m%c\n" '[' 'memoryleak?' ']';
		else
			printf "%c${ESC}[32m%s${ESC}[m%c\n" '[' 'No memoryleak' ']';
		fi
	else
		printf "\n"
	fi
	if $see_the_error_message; then
		cat $$
		echo ""
	fi
	rm $$
	rm $tmpfile
done
echo "$ac / $all"
