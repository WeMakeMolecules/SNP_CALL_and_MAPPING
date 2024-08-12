# SNP_CALL_and_MAPPING
This is s simple repository for mapping reads, SNP calling and other SNP-related operations

##SNP plotter                                                                                                    
a simple script that extracts all the SNPS from a set of VCF files and creates a two-column table              
column 1 is the base coordinate and column 2 is the total number of SNPs for that base in the set of VCF files 
just run it in a folder with the VCF files and provide the gene number:                                        
 e. g. perl SNP_PLOTTER.pl g999                                                                                
outputs are 4 files, each has a table, all snps, and codons 1,2 and 3                                          

##map_and_vcf.sh
how to use: sh map_and_vcf.sh #usage: $1= read suffix $2= reference.fasta
the .fna file is the reference genome/gene set in fasta file in this case REF is an alias for the index


by Pablo pcruzm@biosustain.dt.dk                                                                               
10-1-23,                                                                                                       
#viva la perl!  
