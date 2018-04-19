#!/usr/bin/env bash

if [ "$#" -eq 0 ]
	then echo "  ** INVALID USAGE**. Check -h for help "
	exit
fi

while getopts "i:h" arg; do
case $arg in
i) input="$OPTARG" ;;
h) help=TRUE ;;
\?) echo " Missing arguments or invalid usage. Check -h for help "; exit  ;;
esac
done
shift $((OPTIND - 1))

if [ "$help" == "TRUE" ]
then echo "  Usage options: ./strain.sh -i <filename>
   -i   input file name
   -h   help
    example:
	./strain.sh -i SRR12345.fasta
	./strain.sh -i SRR12345.fq"
exit
fi

src="${BASH_SOURCE[0]}"
src_dir=`dirname $src`
cd $src_dir/phylogeny/strain_detect

perl seeker.pl $input -d ./database/ -verbose -o $input"_strain_result"

