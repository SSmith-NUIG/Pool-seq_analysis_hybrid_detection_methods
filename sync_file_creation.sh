#!/bin/sh 
#SBATCH --job-name="syncfile"
#SBATCH -o /data/ssmith/logs/sync_file_creation_%A_%a.out
#SBATCH -e /data/ssmith/logs/sync_file_creation_%A_%a.err
#SBATCH -c 6

module load java

java -jar /home/ssmith/popoolation2_1201/mpileup2sync.jar \
--input /data2/ssmith/matching_snps_pop_cerana.mpileup \
--output /data2/ssmith/matching_snps_pop_cerana.sync \
--min-qual 20 \
--fastq-type sanger \
--threads 12
