# Genome Assembly

This repository contains a set of comparative genomics scripts for Team II's comparative genomics group.

For general info, see the [project's wiki page](http://www.compgenomics2018.biosci.gatech.edu/Team_II_Comparative_Genomics_Group).

## File Structure and Usage

The repository is organized as follows:

    .
    ├── strain.sh       		# Strain determination script
    ├── whole_genome            # Whole genome realated scripts
    │   ├── clustering          # Clustering based on whole genome similiraity
    ├── phylogeny               # Phylogeny realted scripts
    └

To determine strain of an assembled genome, run

    ./strain.sh assembly.fasta

Some of the scripts **might only work on** `biogenome2018b.biology.gatech.edu` server since they rely on specific files present on this server.
