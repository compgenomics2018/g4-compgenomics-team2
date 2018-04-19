#!/bin/bash
declare -a file_array

let l=0
while IFS=$'\n' read -r line_data;
do
    file_array[l]="${line_data}"
    ((++l))
done < ./file_list

for ((i = 0; i < ${#file_array[@]}; ++i))
do
for ((j = i; j < ${#file_array[@]}; ++j))
do 
	mash dist $(find ${file_array[$i]}*) $(find ${file_array[$j]}*) 
done
done
