#################################################################################################################
#SNP plotter                                                                                                    #
#a simple script that extracts all the SNPS from a set of VCF files and creates a two-column table              #
#column 1 is the base coordinate and column 2 is the total number of SNPs for that base in the set of VCF files #
#just run it in a folder with the VCF files and provide the gene number:                                        #
# e. g. perl SNP_PLOTTER.pl g999                                                                                #
#outputs are 4 files, each has a table, all snps, and codons 1,2 and 3                                          #
#by Pablo pcruzm@biosustain.dt.dk                                                                               #
#10-1-23,                                                                                                       #
#viva la perl!                                                                                                  #
#################################################################################################################
open OUT, ">ALL_SNPS.txt" or die "I cant save the ALL SNP file\n";
@files = `ls *.vcf`;
%snpcount = ();
print "Processing VCF files\n";
foreach (@files){
	$filename="$_";
	  chomp $filename;
	$ref_gene=$ARGV[0];
	$cont=0;
	$snpcount{$cont}=0;
	@gene_snps = `grep \"\#\" $filename -v|grep $ref_gene\.t1 `;
	$linelength = `grep \"\#\" $filename |grep $ref_gene`;
	$linelength=~/.+length\=(\d+)\>/;
	$length ="$1";
	print "processig gene $ref_gene with $length bases in $filename\n";	
	while ($cont < $length){
		$cont++;
		foreach (@gene_snps) {
			$vcfline="$_";
			@columns = split (/\t/,$vcfline);
				if ($columns[1]==$cont){
					$snpcount{$cont}+=1;
				}#SNP at position $cont
				else {
					$snpcount{$cont}+=0 ;
				}#no SNP at position $cont
		}#looping through recorded snps
	}#within the lenght loop
$cont=0;
}#within file loop
print "Preparing outputs\n";	
#printing all SNPS
$number=1;
for(keys %snpcount){
	print OUT "$number\t$snpcount{$number}\n";
	$number++;
}
#printing 1,4,7 SNPS
open FILE, "ALL_SNPS.txt" or "die I cannot read the ALL SNP file\n";
open OUT1, ">base1_SNPS.txt" or die "I cant save the 1 SNP file\n";
$codon=1;
$linenumber=0;
while ($line=<FILE>){
	$linenumber++;
	if ($linenumber == $codon){
	print OUT1 $line;
	$codon+=3;
	}
	else {
	$dummy=0;
	}
}
close FILE;
open FILE, "ALL_SNPS.txt" or "die I cannot read the ALL SNP file\n";
open OUT2, ">base2_SNPS.txt" or die "I cant save the 2 SNP file\n";
$codon=2;
$linenumber=0;
while ($line=<FILE>){
	$linenumber++;
	if ($linenumber == $codon){
	print OUT2 $line;
	$codon+=3;
	}
	else {
	$dummy=0;
	}
}
close FILE;
open FILE, "ALL_SNPS.txt" or "die I cannot read the ALL SNP file\n";
open OUT3, ">base3_SNPS.txt" or die "I cant save the 3 SNP file\n";
$codon=3;
$linenumber=0;
while ($line=<FILE>){
	$linenumber++;
	if ($linenumber == $codon){
	print OUT3 $line;
	$codon+=3;
	}
	else {
	$dummy=0;
	}
}
close FILE;
print "All done, have fun!\n";	
