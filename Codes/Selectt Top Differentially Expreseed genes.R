setwd("C:/Users/Akram/Desktop/SharifWorkshop/")
library(Biobase)
library(GEOquery)
library(limma)
library(pheatmap)
library(gplots)
library(ggplot2)
library(reshape2)
library(plyr)

series <-"GSE9476"
platform <- "GPL96"

#### Load Data
gset <- getGEO(series, GSEMatrix =TRUE, AnnotGPL=TRUE,destdir = "MyData/")
 
 gpl <- getGEO('GPL96', destdir="MyData/")
 colnames(Table(gpl))
 GSymbol_prob <- Table(gpl)[, c(1, 11)]
 dim(GSymbol_prob)
 
 GSymbol_prob <- sub("///.*","",GSymbol_prob)
 write.table(GSymbol_prob,file = "Gsymbol_prob.txt", quote = F, row.names = F)
 
 if (length(gset) > 1) idx <- grep(platform, attr(gset, "names")) else idx <- 1
 gset <- gset[[idx]]
 
 gr <- c("CD34", rep("BM",10), rep("CD34", 7), rep("AML",26),rep("PB",10),rep("CD34",10))
 
 ex <- exprs(gset) 
 
 #### Quality Control
 
 pdf("Results/boxplot.pdf" ,width = 64)
 boxplot(ex)
 dev.off()
 
 #### DEG
 gr <- factor(gr)
 gset$description <- gr #categories
 design <- model.matrix(~ description + 0, gset)
 colnames(design) <- levels(gr)
 
 fit <- lmFit(gset, design)
 cont.matrix  <- makeContrasts(AML - CD34, levels=design)
 fit2 <- contrasts.fit(fit, cont.matrix)
 fit2 <- eBayes(fit2, 0.01)
 tT <- topTable(fit2, adjust="fdr", sort.by="B", number=Inf)
 
 tT <- subset(tT, select=c("Gene.symbol","Gene.ID","adj.P.Val","logFC"))
 write.table(tT, "Results/AML_CD34.txt", row.names=F, sep="\t", quote=F)
 
 #### Select top significant aml gene list
 
 aml.up <- subset(tT,logFC > 1 & adj.P.Val < 0.05)
 aml.up.genes <- unique(as.character(strsplit2(aml.up$Gene.symbol,"///")))
 write.table(aml.up.genes,file = "Results/AML_CD34_UP.txt", quote = F, row.names = F, col.names = F)
 
 aml.down <- subset(tT,logFC < -1 & adj.P.Val < 0.05)
 aml.down.genes <- unique(as.character(strsplit2(aml.down$Gene.symbol,"///")))
 write.table(aml.down.genes,file = "Results/AML_CD34_DOWN.txt", quote = F, row.names = F, col.names = F)
 
 

