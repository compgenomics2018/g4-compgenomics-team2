# Comparative Genomics


This repository contains a set of comparative genomics scripts for Team II's comparative genomics group.

For general info, see the [project's wiki page](http://www.compgenomics2018.biosci.gatech.edu/Team_II_Comparative_Genomics_Group).

## File Structure and Usage

The repository is organized as follows:

    .
    ├── strain.sh               # Strain determination script
    ├── whole_genome            # Whole genome related scripts
    │   ├── clustering          # Clustering based on whole genome similarity
    │   ├── gwas                # Bacterial GWAS scripts and results
    ├── phylogeny               # Phylogeny related scripts
    │   ├── ksnp                # kSNP scripts and results
    │   ├── strain_detect       # Scripts and dependencies for strain detection
    └

To determine strain of an assembled genome, run

    ./strain.sh -i assembly.fasta

Some of the scripts **might only work on** `biogenome2018b.biology.gatech.edu` server since they rely on specific files present on this server.

## Dependencies

* All the necessary dependencies for `strain.sh` are present in the `phylogeny/strain_detect` directory.
* Database required for strain detection can be downloaded from:
    * [pre-built Database (*18GB*)](http://bioinfo.ut.ee/strainseeker/executables/ss_db_w32_4324.tar.gz)
    * [pre-built Database  (*4GB*)](http://bioinfo.ut.ee/strainseeker/downloads/ss_db_w16.tar.gz)

    *OR*

    * A ***Klebsiella*-specific** (*2.5GB*) Database can be accessed on the `biogenome2018b.biology.gatech.edu` server at
        `/projects/data/important_data/reference_DB/seeker_genomes/kleb_DB`
* The database need to be put in the `phylogeny/strain_detect/database` directory