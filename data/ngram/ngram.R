setwd("U:/mcm/presentations/CompTools/introR/data")
library(ggplot2)

w<-read.table("mywords.all.txt",sep='\t')
tot<-read.table("googlebooks-eng-all-totalcounts-20090715.txt",skip=1);
colnames(tot)<-c("year","count","pages","books")
colnames(w)<-c("word","year","count","pages","books")

for(i in 1:length(tot[,1]))
{
	iv<-w[,2] == tot[i,1]
	w[iv,"norm"]<-w[iv,"count"]/tot[i,"count"]
}

iv<-w[,2] > 1800 & (w[,1] == 'horse' | w[,1] == 'car')
v<-w[iv,]
p<-ggplot(data = v, mapping = aes(x = year, y = norm,group=word)) 
p + stat_smooth(se=FALSE,method='loess',aes(colour=word)) + geom_line(aes(colour=word))


