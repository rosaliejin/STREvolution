#!/bin/bash

set -e

SPECIES=$1

echo "Running on species ${SPECIES}..."

TRF=/storage/yjin/TreeofLife/trf/${SPECIES}/${SPECIES}.trf.filt.bed 
#ANNOT=/storage/yjin/TreeofLife/annotation/${SPECIES}.gtf
ANNOT=/storage/yjin/TreeofLife/UCSCannotation/${SPECIES}.gtf

# Get BED with chrom, start, end, period, motif+, motif-
cat $TRF | cut -f 1-5 | ./add_revcomp.py | bedtools sort -i stdin > ${SPECIES}.bed

# Get TSS + strand
cat $ANNOT | awk '($3=="transcript")' | cut -f 1,4,5,7 | awk '{print $1 "\t" ($4=="+"?$2"\t"$2+1:$3"\t"$3+1) "\t" $4 }' > ${SPECIES}.tss.bed
bedtools sort -i ${SPECIES}.tss.bed > ${SPECIES}.tss.sorted.bed

# Get acc/donor + strand
cat $ANNOT  | awk '($3=="exon")' | cut -f 1,4,5,7 | awk '{print $1 "\t" ($4=="+"?$2"\t"$2+1:$3"\t"$3+1) "\t" $4 }' | bedtools sort -i stdin > ${SPECIES}.acc.sorted.bed
cat $ANNOT  | awk '($3=="exon")' | cut -f 1,4,5,7 | awk '{print $1 "\t" ($4=="-"?$2"\t"$2+1:$3"\t"$3+1) "\t" $4 }' | bedtools sort -i stdin > ${SPECIES}.donor.sorted.bed

# Run TSS annotation
/storage/mgymrek/workspace/mgymrek-utils/str_composite_plots.py \
    --hipref ${SPECIES}.bed \
    --targets ${SPECIES}.tss.sorted.bed \
    --motifs A,T,AC,GT,AG,CT,AT,AATG,ATTC,CCG,CGG \
    --prefix ${SPECIES}.tss > ${SPECIES}.strwindows.bed

/storage/mgymrek/workspace/mgymrek-utils/str_composite_plots.py \
    --hipref ${SPECIES}.bed \
    --targets ${SPECIES}.acc.sorted.bed \
    --motifs A,T,AC,GT,AG,CT,AT,AATG,ATTC,CCG,CGG \
    --prefix ${SPECIES}.tss > ${SPECIES}.acc.strwindows.bed

/storage/mgymrek/workspace/mgymrek-utils/str_composite_plots.py \
    --hipref ${SPECIES}.bed \
    --targets ${SPECIES}.donor.sorted.bed \
    --motifs A,T,AC,GT,AG,CT,AT,AATG,ATTC,CCG,CGG \
    --prefix ${SPECIES}.tss > ${SPECIES}.donor.strwindows.bed

# Cleanup
rm ${SPECIES}.bed
rm ${SPECIES}.acc.sorted.bed
rm ${SPECIES}.donor.sorted.bed
rm ${SPECIES}.tss.sorted.bed
rm ${SPECIES}.tss.bed
rm ${SPECIES}*.closest.bed
