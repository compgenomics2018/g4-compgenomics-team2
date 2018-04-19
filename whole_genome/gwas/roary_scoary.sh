#!/bin/bash

usage="Usage: roary_scoary.sh -i <input_dir> -t <traits.txt> [options] \nOptions:\n
-i <*.gff>: input gffs  (absolute path preferred) [AT LEAST 2 REQUIRED. MUST HAVE EXTENSION .gff]\n
-o <dir name>: output directory (absolute path preferred) [REQUIRED]\n
-t <filename>: traits file [REQUIRED] (absolute path preferred)\n 
-c <num>: number of cpu threads (default 1)\n
-h : usage information\n"

##########################################
threads=1;
while getopts "i:p:o:c:t:h" opt;
do
	case $opt in
	i)
		input_dir=$OPTARG
		if [ ! -e $input_dir ]; then
			echo $input_dir 'does not exist'
		fi
	;;
	o)
		output_dir=$OPTARG
	;;
	c)
		threads=$OPTARG
	;;
	t)
		traits=$OPTARG
		if [ ! -e $traits ]; then
			echo $traits 'does not exist'
		fi
	;;
	h) help=true ;;
	*) help=true ;;	
	esac
done

###############################################

if [ $help ]
then
	echo -e $usage
	exit
fi

###############################################

if [ -z "$input_dir" -o -z "$output_dir" -o -z "$traits" ]; then
	echo -e "Some required options are null. Please specify appropriate options. \n" 
	echo -e $usage
	exit
fi

if [ ! -e $input_dir -o ! -e $traits ]; then
	echo -e $usage
	exit
fi

if [ -e $output_dir ]; then
	echo -e "Output directory already exists.\n"
	exit
fi

################################################

roary -f $output_dir -v -p $threads $input_dir*.gff 
scoary -t $traits -g $output_dir/gene_presence_absence.csv -o $output_dir -p 1 -c BH -u --threads $threads