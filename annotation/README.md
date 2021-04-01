This snakemake workflow (in progress) does the following:

1. Search for STR in annotated regions
2. Analyze STR results

Next up todo: fill in more species, tss region

Currently, it assumes genome fasta files are in:

```
$GENOMESDIR/$annotations/{species}.coding.bed
$GENOMESDIR/$annotations/{species}.introns.bed
$GENOMESDIR/$annotations/{species}.tss.bed


```

e.g. `/storage/mgymrek/TReeofLife/genomes/bosTau7/bosTau7.fa`. Note, the directory name is the same as the short species name to make automated changing of paths easier. This could be replaced in the snakefile with a path to a different directory containing genomes.

Output is written to `$TRFDIR`. The path to this can e changed in the snakefile.

To run, just type `snakemake`

To add more species, update the list of `SPECIES` in the snakefile, assuming their genome fasta files are available in the relevant location.
