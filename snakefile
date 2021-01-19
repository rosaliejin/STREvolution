#wildcard_constraints:
#    sample="[^.]*"

#import data from the website
rule import_data:
    input:
        "url"
    output:
        "data/{sample}.fastq"
        "{sample}.fastq"
    shell:
        "curl -o {output[1]} {input} > {output[0]} "
