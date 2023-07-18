###############################################
#  raw_snps_counter.pl                        #
#  A simple script to count the SNPS per gene #
#  by Pablo Cruz-Morales                      #
#  pcruzmbiosustain.dtu.dk                    #
###############################################

#input: one or more vcf files obtained wit the map_and_vcf.sh script
#output a table
#use: place this script in the same directory as the vcf files that you want to iclude in the table and run
#find the total number of genes in the reference genome (e. g. grep ">" reference.fna -c)
# perl RAW_SNP_counter.pl 8722


#defining the number of CDS in the ref genome
$ref="$ARGV[0]";
#making a list of vcf files in the directory
$filelist=`ls *.filtered.vcf`;
#grabbing the file names without extensions
$filelist=~s/.filtered.vcf//g;
#formatting the name of the file for the table
$filelist=~s/\n/\t/g;
chomp $totalcount;
#printing the header of the table
print "Locus\t$filelist\tTOTAL\n";
#Defining the number of genes to search
$cont=0;
while ($cont < $ref){
$cont++;
#counting SNPS in gene $cont for all files
$totalcount=`cat *.filtered.vcf |grep ".g$cont.t1"  -c`;
#counting SNPS in gene $cont for each file
$perstraincount=`grep ".g$cont.t1" -c *.filtered.vcf`;
#Formatting grep output
$perstraincount=~s/.+\://g;
$perstraincount=~s/\n/\t/g;
chomp $totalcount;
#printing counts
print "CDS.$cont\t$perstraincount\t$totalcount\n";
}

close;
