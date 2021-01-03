#!/bin/bash

path="./cub3D"
see_the_error_message=true
memory_leak_check=true
ESC=$(printf '\033')
all=0
ac=0
array=()
array_leak=()
tmpfile=$(mktemp)
for f in ./${1:-*}/*; do
	all=$(( $all + 1 ))
	$path $f 2> $$
	if [ -s $$ ]; then
		ac=$(( $ac + 1 ))
		printf "%-50s%c${ESC}[32m%s${ESC}[m%c" $f '[' 'OK' ']';
	else
		array=("${array[@]}" $f)
		printf "%-50s%c${ESC}[31m%s${ESC}[m%c\n" $f '[' 'Fail' ']';
	fi
	if  $memory_leak_check ; then
		valgrind --leak-check=full $path $f 2>$tmpfile
		memoryleak=`tail -1 $tmpfile | awk '{print $4}'`
		if [ $memoryleak != 0 ]; then
			array_leak=("${array[@]}" $f)
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
done
rm $$
rm $tmpfile
echo "$ac / $all"
echo "===Fail caused by these files==="
for e in ${array[@]}; do
	echo "${e}"
done
echo "===Leak caused by these files==="
for e in ${array_leak[@]}; do
	echo "valgrind --leak-check=full $path ${e}"
done
