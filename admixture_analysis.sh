#!/bin/sh 
#SBATCH --job-name="mpileup"
#SBATCH -o /data/ssmith/logs/mpileup_creation_%A_%a.out
#SBATCH -e /data/ssmith/logs/mpileup_creation_%A_%a.err
#SBATCH -N 1
#SBATCH -n 12
#"$SLURM_ARRAY_TASK_ID"
# 33-38,40-57%12
source activate bcfenv
#/home/ssmith/samtools-0.1.16/

bcftools mpileup -R matching_snp_locations.txt \
-f /data/ssmith/c_l_genome/apis_c_l_genome.fa  \
-b bam_file_list.txt \
| bcftools call -vm > admixture.vcf

module load plink2

plink2 --vcf /admixture.vcf --make-bed \
--out admixture_out \
--allow-extra-chr --max-alleles 2
