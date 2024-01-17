# Hybrid detection admixture plotting
tbl=read.table("/home/stephen/Documents/Thesis/Hybrid_detection/Results/Admixture_results.csv", sep=",", header=TRUE)
sample_names = tbl$Sample
tbl = tbl[,-1]
png("/home/stephen/Documents/Thesis/Hybrid_detection/Results/admixture_plot.png", width = 5000, height = 600, units = "px")
par(mar = c(9, 4, 5, 5))
barplot_adm = barplot(t(as.matrix(tbl)), col=rainbow(5),
                      xlab="", ylab="Ancestry via Admixture", border=NA, names=sample_names, las=2, tcl=0.5) +
  title(xlab="Colony", mgp=c(7,1,0), family="Calibri Light",cex.lab=1.2)
legend("topright", inset=c(-0.11,0),legend = c("M", "C"), fill = c("Yellow", "Red"), title=c("Lineage"))
axis(1,pos=5.5)
dev.off()

# Hybrid detection F4-ratio plotting

tbl=read.table("/home/stephen/Documents/Thesis/Hybrid_detection/Results/F4_ratio_results.csv", sep=",", header=TRUE)
sample_names = tbl$Sample
tbl$Clinegae = 1-tbl$Estimate
tbl$Mlinegae = tbl$Estimate

tbl = tbl[,c(6,7)]

png("/home/stephen/Documents/Thesis/Hybrid_detection/Results/F4ratio_plot.png", width = 5000, height = 600, units = "px")
par(mar = c(9, 4, 5, 5))
barplot_adm = barplot(t(as.matrix(tbl)), col=rainbow(5),
                      xlab="", ylab="Ancestry via F4ratio", border=NA, names=sample_names, las=2, tcl=0.5) +
  title(xlab="Colony", mgp=c(7,1,0), family="Calibri Light",cex.lab=1.2)
legend("topright", inset=c(-0.11,0),legend = c("M", "C"), fill = c("Yellow", "Red"), title=c("Lineage"))
axis(1,pos=5.5)
dev.off()

# Hybrid detection FST plotting

tbl=read.table("/home/stephen/Documents/Thesis/Hybrid_detection/Results/FST_results.csv", sep=",", header=TRUE)
sample_names = tbl$Sample
tbl$Clinegae = 1 - tbl$FST_Average
tbl$Mlinegae = tbl$FST_Average

tbl = tbl[,c("Clinegae","Mlinegae")]

png("/home/stephen/Documents/Thesis/Hybrid_detection/Results/FST_plot.png", width = 500, height = 300, units = "px")
par(mar = c(9, 4, 5, 5),xpd=TRUE)
barplot_adm = barplot(t(as.matrix(tbl)), col=rainbow(5),
                      xlab="", ylab="Ancestry via FST", border=NA, names=sample_names, las=2, tcl=0.5) +
  title(xlab="Colony", mgp=c(7,1,0), family="Calibri Light",cex.lab=1.2)
legend("topright", inset=c(-0.11,0),legend = c("M", "C"), fill = c("Yellow", "Red"), title=c("Lineage"))
axis(1,pos=1.5)

dev.off()

library(PMCMRplus)

ranks_df = read.csv("/home/stephen/Documents/Thesis/Hybrid_detection/Methods/hybrid_methods_ranked.csv", sep=",", row.names = "Sample")
ranks_matrix = data.matrix(ranks_df)
wilcox.test(ranks_df$Admixture, ranks_df$FST, paired= TRUE)

wilcox.test(ranks_df$Admixture, ranks_df$F4ratio, paired = TRUE)

wilcox.test(ranks_df$FST, ranks_df$F4ratio, paired= TRUE)

friedmanTest(ranks_matrix)

cor.test(ranks_df$Admixture, ranks_df$F4ratio, method="spearman")
cor.test(ranks_df$Admixture, ranks_df$FST, method="pearson")
cor.test(ranks_df$FST, ranks_df$F4ratio, method="pearson")

library("ggplot2")                     # Load ggplot2 package 
library("GGally") 

ggpairs(ranks_df, diag = list(continuous = "blankDiag"), axisLabels = "internal",
        title = "Comparison of hybridisation detection methods") + 
  theme( strip.text = element_text(size = 40))
