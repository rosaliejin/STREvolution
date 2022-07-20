GENOMESDIROLD="/storage/mgymrek/TReeofLife/genomes"
GENOMESDIR="/storage/yjin/TreeofLife/data"
TRFDIR="/storage/yjin/TreeofLife/trf"
YJDIR="/storage/mgymrek/TReeofLife/SnakemakeTest"

wildcard_constraints:
    species="[^.]*"

#ponAbe2 and ponAbe3 removed from the list
SPECIES = ['Ecoli','Yersinia_pestis','Bacillus_cereus','Streptococcus_pneumoniae',"ce11","ailMel1","anoCar2","anoGam3","apiMel2","aplCal1","aptMan1","aquChr2","balAcu1","braFlo1","caePb2","caeJap1","caeRem3","calMil1","cavPor3","cerSim1","chlSab2","choHof1","chrPic1", "criGriChoV2","danRer11","dasNov3","dipOrd1","dm6","droPer1","droSec1","droSim1","echTel2","equCab3","felCat9","gadMor1","geoFor1","galGal6","hetGla2","latCha1","loxAfr3","macFas5","macEug2","manPen1","melUnd1","micMur2","musFur1","myoLuc2","nanPar1","nasLar1","nomLeu3","ochPri3","oreNil2","ornAna2","oryCun2","oryLat2","otoGar3","oviAri4","panPan3","panTro6","papAnu4","papHam1","petMar3","priPac1","proCap1","pteVam1","rheMac10","sacCer3","saiBol1","sarHar1","sorAra2","speTri2","strPur2","susScr11","taeGut2","tarSyr2","tetNig2","thaSir1","triMan1","tupBel1","vicPac2",'bosTau9','calJac4','canFam5','ci3','dp4','droAna3','droEre2','droGri2','droMoj3','droVir3','fr3','gorGor6','melGal5','rn7','xenTro10','hg38','mm39']
#SPECIES = ["eboVir3","wuhCor1","ce11","sacCer3","ailMel1","anoCar2","anoGam3","apiMel2","aplCal1","aptMan1","aquChr2","balAcu1","bosTau7","braFlo1","caePb2","caeJap1","caeRem3","calJac1","calMil1","canFam3","cavPor3","cerSim1","chlSab2","choHof1","chrPic1", "ci2","criGriChoV2"]
#SPECIES = ["danRer11","dasNov3","dipOrd1","dm6","droPer1","dp3","droSec1","droSim1","echTel2","equCab3","felCat9","fr2","gadMor1","geoFor1","galGal6","gorGor5","hetGla2","hg19","latCha1","loxAfr3","macFas5","macEug2","manPen1","melGal1","melUnd1","micMur2","mm10","musFur1","myoLuc2"]
#SPECIES = ["nanPar1","nasLar1","nomLeu3","ochPri3","oreNil2","ornAna2","oryCun2","oryLat2","otoGar3","oviAri4","panPan3","panTro6","papAnu4","papHam1","petMar3","ponAbe3","priPac1","ponAbe2","proCap1","pteVam1","rn6","rheMac10","sacCer3","saiBol1","sarHar1","sorAra2","speTri2","strPur2","susScr11","taeGut2","fr2","tarSyr2","tetNig2","thaSir1","triMan1","tupBel1","vicPac2","xenTro9","droAna2","droEre1", "droGri1","droMoj2","droVir2"]
#SPECIES = ['calJac1', 'ci2', 'danRer11', 'dm6', 'droPer1', 'droSec1', 'echTel2', 'equCab3', 'gadMor1', 'geoFor1', 'galGal6', 'hetGla2', 'latCha1', 'macEug2', 'manPen1', 'melGal1', 'micMur2', 'mm10', 'myoLuc2', 'nanPar1', 'nasLar1', 'nomLeu3', 'ochPri3', 'ornAna2', 'ponAbe3', 'ponAbe2']
#SPECIES = ['Ecoli','Yersinia_pestis','Bacillus_cereus','Streptococcus_pneumoniae']

rule all:
    input:
        "%s/TRSpecies_PeriodPercs.pdf"%YJDIR,
        "%s/TRSpecies_GenomePerc.pdf"%YJDIR,
        "%s/TRSpecies_Density.pdf"%YJDIR,
        "%s/TRSpecies_STRnum.pdf"%YJDIR,
        #[("%s/organize_{species}.csv"%YJDIR).format(species=species) for species in SPECIES]
	#"%s/TRSpecies_homopolymer.pdf"%YJDIR,
	#"%s/TRSpecies_dinucleotide.pdf"%YJDIR,
	#"%s/TRSpecies_trinucleotide.pdf"%YJDIR,
	#"%s/TRSpecies_tetranucleotide.pdf"%YJDIR,
	#"%s/TRSpecies_pentanucleotide.pdf"%YJDIR,
	#"%s/TRSpecies_hexanucleotide.pdf"%YJDIR
        "%s/organize_unit.csv"%YJDIR


rule index_fa:
    input:
        "%s/{species}/{species}.fa"%GENOMESDIR
    output:
        "%s/{species}/{species}.fa.fai"%GENOMESDIR
    shell:
        "samtools faidx {input}"

# This rule splits a single fasta file by chrom
# It additionally outputs {species}.chrom, so that the rule has an output file to check
rule split_fa:
    input:
        "%s/{species}/{species}.fa"%GENOMESDIR,
        "%s/{species}/{species}.fa.fai"%GENOMESDIR
    output:
        "%s/{species}/bychrom/{species}.chroms"%GENOMESDIR
    shell:
        "./split_fa.sh {GENOMESDIR} {wildcards.species}"

# Run TRF on each chromosome, and output to a single TRF bed file per species
rule run_trf:
    input:
        "%s/{species}/bychrom/{species}.chroms"%GENOMESDIR
    output:
        "%s/{species}/{species}.trf.bed"%TRFDIR
    shell:
        "./make_trf.sh {GENOMESDIR} {wildcards.species} {output}"

# Filter initial TRF output
rule filter_trf:
    input:
        "%s/{species}/{species}.trf.bed"%TRFDIR
    output:
        "%s/{species}/{species}.trf.filt.bed"%TRFDIR
    shell:
        "python3 filter_TRF_nopandas.py {input} {output}"

# TODO - below make a different rule for stats on each TRF file
# Save those results to files in TRFDIR/{species}
# Can have nother rule that will combine stats across all species to a big table

#count for homopolymer, dinucleotide, etc.,
rule str_count:
    input:
        "%s/{species}/{species}.trf.filt.bed"%TRFDIR
    output:
         "%s/{species}/{species}.str_count.txt"%YJDIR
    shell:
        "for period in $(seq 1 6); do awk -v\"period=$period\" '$4==period'  {input} | wc -l | awk -v\"period=$period\" '{{print period \"\t\" $0}}' ; done > {output}"

#count the length of entire genome
rule genome_length:
    input:
        "%s/{species}/{species}.str_count.txt"%YJDIR, "%s/{species}/{species}.fa.fai"%GENOMESDIR
    output:
        "%s/{species}/{species}.genome_length.txt"%YJDIR
    shell:
         "awk '{{print $2}}' {input[1]} | awk '{{ sum+=$1 }}END{{ print sum }}' > {output}"

#count the number of str base
rule str_base:
    input:
        "%s/{species}/{species}.genome_length.txt"%YJDIR, "%s/{species}/{species}.trf.filt.bed"%TRFDIR
    output:
        "%s/{species}/{species}.str_base.txt"%YJDIR
    shell:
         "awk '{{print length($6)}}'  {input[1]} | awk '{{sum+=$1 }}END{{ print sum }}'> {output}"

#count the average length of each repeated unit
#rule repeat_length:
#    input:
#        "%s/{species}/{species}.str_base.txt"%YJDIR, "%s/{species}/{species}.trf.filt.bed"%TRFDIR
#    output:
#        "%s/{species}/{species}.repeat_length.txt"%YJDIR
#    shell:
#         "for period in $(seq 1 6); do awk -v\"period=$period\" '$4==period'  {input} | awk '{{print length($6)}}' | awk '{{sum+=$1 }}END{{ print sum/NR }}'; done > {output}"

#count the length of each homopolymer
rule homo_length:
    input:
        "%s/{species}/{species}.str_base.txt"%YJDIR, "%s/{species}/{species}.trf.filt.bed"%TRFDIR
    output:
        "%s/{species}/{species}.repeat_homo.txt"%YJDIR
    shell:
        "awk '$4==1' {input[1]} | awk '{{print length($6)}}' > {output}"

#count the length of each dinucleutide
rule di_length:
    input:
        "%s/{species}/{species}.repeat_homo.txt"%YJDIR, "%s/{species}/{species}.trf.filt.bed"%TRFDIR
    output:
        "%s/{species}/{species}.repeat_di.txt"%YJDIR
    shell:
        "awk '$4==2' {input[1]} | awk '{{print length($6)}}' > {output}"

        #count the length of each trinucleutide
rule tri_length:
    input:
        "%s/{species}/{species}.repeat_di.txt"%YJDIR, "%s/{species}/{species}.trf.filt.bed"%TRFDIR
    output:
        "%s/{species}/{species}.repeat_tri.txt"%YJDIR
    shell:
        "awk '$4==3' {input[1]} | awk '{{print length($6)}}' > {output}"

#count the length of each tetranucleutide
rule tetra_length:
    input:
        "%s/{species}/{species}.repeat_tri.txt"%YJDIR, "%s/{species}/{species}.trf.filt.bed"%TRFDIR
    output:
        "%s/{species}/{species}.repeat_tetra.txt"%YJDIR
    shell:
        "awk '$4==4' {input[1]} | awk '{{print length($6)}}' > {output}"

#count the length of each pentanucleutide
rule penta_length:
    input:
        "%s/{species}/{species}.repeat_tetra.txt"%YJDIR, "%s/{species}/{species}.trf.filt.bed"%TRFDIR
    output:
        "%s/{species}/{species}.repeat_penta.txt"%YJDIR
    shell:
        "awk '$4==5' {input[1]} | awk '{{print length($6)}}' > {output}"

#count the length of each hexanuleutide
rule hexa_length:
    input:
        "%s/{species}/{species}.repeat_penta.txt"%YJDIR, "%s/{species}/{species}.trf.filt.bed"%TRFDIR
    output:
        "%s/{species}/{species}.repeat_hexa.txt"%YJDIR
    shell:
        "awk '$4==6' {input[1]} | awk '{{print length($6)}}' > {output}"

#Creating table to organize annalysis
rule organize:
    input:
        "%s/{species}/{species}.str_count.txt"%YJDIR, "%s/{species}/{species}.genome_length.txt"%YJDIR, "%s/{species}/{species}.str_base.txt"%YJDIR, "%s/{species}/{species}.repeat_penta.txt"%YJDIR
    output:
        "%s/organize_{species}.csv"%YJDIR, "%s/organize_{species}_unitlength.csv"%YJDIR
    shell:
         "python3 \"STREvolution_Stat.py\" {input[0]} {input[1]} {input[2]} {wildcards.species} {output[0]} {input[3]} {output[1]}"

rule combine_organize:
    input:
         [("%s/organize_{species}.csv"%YJDIR).format(species=species) for species in SPECIES]
    output:
        "%s/organize.csv"%YJDIR
    shell:
        "cat {input} > {output}"

rule combine_unitorganize:
    input:
         [( "%s/organize_{species}_unitlength.csv"%YJDIR).format(species=species) for species in SPECIES]
    output:
        "%s/organize_unit.csv"%YJDIR
    shell:
        "cat {input} > {output}"
rule plot:
    input:
       "%s/organize.csv"%YJDIR
    #if multiple figures are saved in this step, what should be the output?
        "%s/TRSpecies_PeriodPercs.pdf"%YJDIR, "%s/TRSpecies_GenomePerc.pdf"%YJDIR, "%s/TRSpecies_Density.pdf"%YJDIR,"%s/TRSpecies_homopolymer.pdf"%YJDIR,"%s/TRSpecies_dinucleotide.pdf"%YJDIR,"%s/TRSpecies_trinucleotide.pdf"%YJDIR,"%s/TRSpecies_tetranucleotide.pdf"%YJDIR,"%s/TRSpecies_pentanucleotide.pdf"%YJDIR,"%s/TRSpecies_hexanucleotide.pdf"%YJDIR, "%s/TRSpecies_STRnum.pdf"%YJDIR
    output:
    shell:
        "python \"Tree_Of_Life_Graph.py\" {input[0]} {output}"
