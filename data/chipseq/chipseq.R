library(ChIPpeakAnno)
data(TSS.mouse.NCBIM37)
library(org.Mm.eg.db)

#targets_quest<-read.table("targets_questmid.txt",header=T,as.is=T);
#targets<-targets_quest
#name<-"questmid"

#targets_macs1e10<-read.table("targets_macs_pval1e-10.txt",header=T,as.is=T);
#targets<-targets_macs1e10
#name<-"macs1e-10"
#
targets_macs1e5<-read.table("targets_macs_pval1e-5.txt",header=T,as.is=T);
targets<-targets_macs1e5
name<-"macs1e-5"

library(biomaRt)
ensembl = useMart("ensembl")
ensembl = useDataset("mmusculus_gene_ensembl",mart=ensembl)
listFilters(ensembl)
listAttributes(ensembl)
getBM(attributes=c("blah"),values=ensids,mart=ensembl)
ens2sym<-getBM(attributes=c("ensembl_gene_id","mgi_symbol"),mart=ensembl)

for(i in 1:length(targets[,1]))
{
	d<-read.table(targets[i,1],as.is=T,sep='\t',skip=1)
	rd<-BED2RangedData(d)
	anno<-annotatePeakInBatch(rd,AnnotationData=TSS.mouse.NCBIM37)
	df<-as.data.frame(anno)
	df2<-data.frame(d,df[match(d[,4],df[,6]),8:14])
	df2$symbol<-ens2sym[match(as.character(df2$feature),ens2sym[,1]),2]
	enrichedGO<-getEnrichedGO(anno,orgAnn="org.Mm.eg.db",maxP=0.05,multiAdj=TRUE,minGOterm=1,multiAdjMethod="BH")
	write.table(unique(enrichedGO$bp[,1:10]),sep='\t',paste(targets$alias[i],".",name,".GO.bp.txt",sep=''),quote=F,row.names=F);
	write.table(unique(enrichedGO$mf[,1:10]),sep='\t',paste(targets$alias[i],".",name,".GO.mf.txt",sep=''),quote=F,row.names=F);
	write.table(unique(enrichedGO$cc[,1:10]),sep='\t',paste(targets$alias[i],".",name,".GO.cc.txt",sep=''),quote=F,row.names=F);
	write.table(df2,paste(targets$alias[i],".",name,".annotated.txt",sep=''),quote=F,row.names=F,sep='\t')
}
