# Pool-seq_analysis_hybrid_detection_methods
Scripts used to compare hybrid detection methods

## First step:
Rename the files to have a number in front of the sample name, separated by an underscore e.g:  
F113O_1.fq.gz becomes something like 25_F133O_1.fq.gz  
This is done for batch submission of jobs on the SLURM cluster using the ```--array```  paramater in the submission script  


## Second step
Run ```VCF_creation.sh``` specify which samples the pipeline will be run on by changing the ```--array``` line in the top of the script

This script will output:  
Unmapped fastqs which we will use for microbiome analysis (see microbiome analysis repo for the rest of this pipeline)  
Bam files which we will use for population analysis  
VCF files which we will use to see which high impact SNPs are present in our data 

## Third step
Run ```mpileup_creation.sh```  
  
This script creates a mpileup file from the bam files which were created in the second step.   
Note: Please enure your outgroup sample is the first bam file in the list of files. This is important when computing F4 statistics.  
It also takes a file which has the genomic locations we want to investigate.   
This file is called ```matching_snp_locations.txt```

## Fourth step
Run ```sync_file_creation.sh```  
  
This script uses the mpileup file from the third step to create a sync file using popoolation2  
This sync file is the input file for PoolFstat to use its F3 and FST hybrid detection methods

## Fifth step
First turn your BAM file list used during the mpileup creation step into a sample names file using sed

sed -i 's:/data2/ssmith/bams/::g' bam_list_file.txt
sed -i 's:_indels.bam::g' bam_list_file.txt
sed -i 's/^[^_]*_//' bam_list_file.txt

Then run ```sync_to_pooldata.R```  

This script takes the sync file as input and outputs the following:  
A pooldata object  
FST for every pairwise combination of populations  
F3 statistics for every combination of 3 populations  
F4 statistics for every combination of 3 populations + Cerana as outgroup 
F4 ratio results for all test colonies

## Sixth step  (FST ANALYSIS)
Run ```combine_pairwise_FSTs.py```  
This python script combines all of the pairwise FSTs we create for each sample into one final matrix  
(you may need to fill in the bottom right of the dataframe manually)  
Once the final dataframe has been made, get the average FST difference between the test colonies and the C-lineage colonies in the data.
This is our final FST used for hybrid detection, sort and rank the results sequentially.

## Seventh step (F4 analysis)
Collect all of the F4 ratio results in a single dataframe, sort and rank sequentially (lowest F4 to highest)

## Eighth step (ADMIXTURE)
Run Create admixture_analysis.sh to create the bed file needed to run ADMIXTURE
Then run ADMIXTURE on this file.
The output was loaded into R and merged with the file containing only the sample names. 
This was then sorted for only our test colonies and ranked from most C-lineage like to least.

## Ninth step (COMPARISONS)
Run Compare_hybrid_methods.R to get plots for each method and a final correlation plot of the ranks given to each test colony


