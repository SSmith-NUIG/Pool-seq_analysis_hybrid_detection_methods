```
library(poolfstat)
library(dplyr)

pnames = read.csv("test_colonies.txt", header=FALSE)
colnames(pnames) = c("Name")

pool_file = read.csv("novo2pool.csv")

filter_file = inner_join(pnames, pool_file, by="Name")

pnames_v = filter_file$Name
poolsize_v = filter_file$Pool_size

load("pooldata_f4ratio")

test_colonies = pnames_v[!pnames_v %in% c("Cerana","AmC109", "AmC419", "AmC423",
 "AmC429", "AmC435","F113O",
"X1", "ITA_LIG1", "ITA_LIG2", "IRL_MEL")]
print(test_colonies)

for (hybrid in test_colonies){
	num_string = paste0("X1,Cerana;AmC109,",hybrid)
	hybrid_f4ratio = compute.f4ratio(fstats, num.quadruplet = num_string,
                            den.quadruplet="X1,Cerana;ITA_LIG1,F113O")
	print(hybrid)
	print(hybrid_f4ratio)
}
```
