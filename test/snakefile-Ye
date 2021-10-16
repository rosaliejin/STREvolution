#wildcard_constraints:
#    sample="[^.]*"
#problem to work on:
#edit the file such that it knows which chromosomes it contains

#import data from the website
rule import_data:
    input:
        "url"
    output:
        "data/{sample}.fa
        "{sample}.fa"
    shell:
        "curl -o {output[1]} {input} > {output[0]} "
#split the file and run the script
rule split_fasta:
    input:
        "data/{sample}.fa"
    #we don't really need a output here as the script will take care of it
    output:

    run:
        #can we use if function like this?
        if "grep -Fx 'scaffold' {input} == ture":
            #probably a version that doesn't take in seperate chromosomes
            "./1_run_trf_new.sh"
        else:
            #can I use | here?; if so, we can finish multiple things within one step
            "./1_split_fasta_example.sh {input} | ./1_run_trf_new.sh"
    
rule str_length:
    input:
        "data/{sample}/{sample}.fa.fai
    output:
        "str_length.txt"
    shell:
        #how to add a new line?
        "awk '$4 == 1' file_name | wc -l > {output}
        awk '$4 == 2' file_name | wc -l > {output}
        awk '$4 == 3' file_name | wc -l > {output}
        awk '$4 == 4' file_name | wc -l > {output}
        awk '$4 == 5' file_name | wc -l > {output}
        awk '$4 == 6' file_name | wc -l > {output}"

rule genome_length:
    input:
        "data/{sample}/{sample}.fa.fai
    output:
        "genome_length.txt"
    shell:
        "awk '{print $2}' {input} | awk '{ sum+=$1 }END{ print "TOTAL LINES COUNTED: "sum } > {output}"

rule total_base:
    input:
        "data/{sample}/{sample}.fa.fai
    output:
        "genome_length.txt"
    shell:
        "awk '{print length($4)}'  {input} | awk '{ sum+=$1 }END{ print "TOTAL LINES COUNTED: "sum }'> {output}"


