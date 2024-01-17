```
library(poolfstat)
library(dplyr)

pnames = read.csv("bam_file_list.txt", header=FALSE)
colnames(pnames) = c("Name")

pool_file = read.csv("novo2pool.csv")

filter_file = inner_join(pnames, pool_file, by="Name")

pnames_v = filter_file$Name
poolsize_v = filter_file$Pool_size

#print("creating pooldata file")
#pooldata = popsync2pooldata(sync.file="/data2/ssmith/matching_snps_pop_f4ffs.sy
nc", 
poolsizes=poolsize_v, 
poolnames=pnames_v, 
min.rc = 4, 
min.cov.per.pool = 10, 
max.cov.per.pool = 500, 
min.maf = 0.01, 
noindel = TRUE, 
nthreads = 12, 
nlines.per.readblock = 50000)

save(pooldata, ascii=TRUE, file="pooldata_f4ratio")

```
