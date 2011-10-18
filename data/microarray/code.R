setwd("U:/mcm/presentations/CompTools/introR/data/microarray")
#d<-read.table("microarray_data.txt",sep='\t',as.is=T,header=T)
#
##delete some empty rows.
#d<-d[-c(1,6,20),]
#
#library(reshape)
#library(plyr)
#d2<-melt(d)
#d2[,4:5]<-do.call("rbind", strsplit(as.character(d2[,2]),"\\.+"))
#d2<-d2[,-2]
#colnames(d2)[3:4]<-c("Type","Year")
#write.table(d2,"data.txt",sep='\t',quote=F,row.names=F)
#

d2<-read.table("data.txt",sep='\t',header=T)

library(RColorBrewer)
cols<-c(brewer.pal(5,"Blues")[3:5],brewer.pal(5,"Oranges")[3:5],brewer.pal(5,"Purples")[3:5],brewer.pal(5,"Reds")[3:5])


