d<-read.table("gene_relationship.txt",sep='\t',as.is=T,header=T)
hist(d[,3]-d[,2],breaks=100,col='blue',main="Yeast Gene Length",cex.axis=.9,xlab='length')
