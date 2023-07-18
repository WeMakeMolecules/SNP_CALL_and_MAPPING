# map_and_vcf.sh          #
# by Pablo Cruz-Morales   #
# pcruzm@biosustain.dtu.dk#

#how to use
#sh map_and_vcf.sh #usage: $1= read suffix $2= reference.fasta
#the .fna file is the reference genome/gene set in fasta file in this case REF is an alias for the index

####COMMMENT THE NEXT LINE IF USING THE SAME REFERENCE EACH TIME###
#bowtie2-build $2 REF

#mapping, output is a SAM file
bowtie2 -x REF -1 $1_1.fastq -2 $1_2.fastq -S $1.sam
#converting sam into BAM (binary file)
samtools view -bS $1.sam > $1.bam
#sorting the bam file
samtools sort $1.bam -o $1.sorted.bam
#now we call variants, the output is VCF file
bcftools mpileup -Ou -f $2 $1.sorted.bam | bcftools call -mv -Ob --ploidy 1 -o $1.bcf
#making the BCF in a VCF file
bcftools view $1.bcf > $1.vcf
#Filtering the SNPS to get the QUAL equal or more than 50
bcftools filter  -i '%QUAL>=50'  $1.vcf >  $1.filtered.vcf
