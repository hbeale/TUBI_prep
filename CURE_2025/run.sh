#!/bin/bash

fasta=$1
bam=$2
outputs=$3
region=$4

for file in $fasta $bam $outputs
do
    if [ ! -e "$file" ]
    then echo "$file is missing" >&2; exit 1
    fi
done

output_name_raw=`basename $bam`
output_name=${output_name_raw/.bam}

echo Running freebayes on $bam
freeBayesSettings="--dont-left-align-indels --pooled-continuous --pooled-discrete -F 0.03 -C 2"
/bin/freebayes-1.3.4-linux-static-AMD64  --region ${region} $freeBayesSettings -f $fasta $bam > /tmp/mini.vcf

echo Running snpEff on /tmp/mini.vcf
snpEffSettings="-nodownload -noNextProt -noMotif -noStats -classic -no PROTEIN_PROTEIN_INTERACTION_LOCUS -no PROTEIN_STRUCTURAL_INTERACTION_LOCUS"

java -Xmx10000m -jar /snpEff/snpEff.jar -v $snpEffSettings hg19 /tmp/mini.vcf >  ${outputs}/${output_name}.ann.vcf

