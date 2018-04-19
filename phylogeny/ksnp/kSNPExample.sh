#!/bin/csh -f

# First run script to find k-mer length
# in_list is the list of names of samples and 0.985 is an example of selecting for 98.5% unique sequence

Kchooser in_list.txt 0.985

# Run with found k-mer length from Kchooser
# Same list as before, OUTDIR is the output directory, -k is k-mer size, -annotated is a list of sample names to grab annotations for.
	# A note on annotation: Sequences need to start with a valid NCBI identification line to be used in annotation.
		# Example being >NC_002952.2 Staphylococcus aureus subsp. aureus strain MRSA252, complete genome 
kSNP3 -in in_list.txt -outdir OUTDIR -k 23 -annotate annotated_list