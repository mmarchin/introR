###############################
# 1. Getting Started
###############################

dir.create("H:/introR")
file.copy(from="U:/mcm/presentations/CompTools/introR/data",to="H:/introR",recursive=T)
file.copy(from="U:/mcm/presentations/CompTools/introR/code/code.R",to="H:/introR")
file.copy(from="U:/mcm/presentations/CompTools/introR/introR.docx",to="H:/introR")
setwd("H:/introR")

#or mac
dir.create("/Volumes/HOME/introR")
file.copy(from="/Volumes/projects/mcm/presentations/CompTools/introR/data",to="/Volumes/HOME/introR",recursive=T)
file.copy(from="/Volumes/projects/mcm/presentations/CompTools/introR/code/code.R",to="/Volumes/HOME/introR/code.R")
file.copy(from="/Volumes/projects/mcm/presentations/CompTools/introR/introR.docx",to="/Volumes/HOME/introR/")
setwd("/Volumes/HOME/introR")

?mean

help.start()

###############################
# 2. R as a calculator
###############################
1+1
2+2
100-20
which(x==6)
10^2
100/4
sqrt(2)
log2(2)
?log2

###############################
# 3. Vectors
###############################

c(1,3,6,8,13)

x <- c(1,3,6,8,13)

x

#create another vector, y.
y <- c(2,5,4,7,12)

y
x[4]

words <- c("hi","how","are","you")

sentences <- c("Hi, how are you?", "I am fine.")

#note -- TRUE and FALSE are special words in R, don't use quotes.
torf <- c(TRUE,TRUE,FALSE,TRUE,TRUE)

v1 <- c(6, 5,"hi")

z <- c(x,y)
z
1:10
m <- 1:10

mean(x)

median(x)

min(y)

max(y)

#which.min returns the POSITION of the minimum element.
which.min(y)

which.max(y)

#sample standard deviation
sd(x)

summary(x)
#correlation
cor(x,y)
length(y)
x==6

plot(x,y)
 
#note, the type="l" below is a lowercase L for line, not the number 1.
plot(x,y,type="l")
 
###############################
# 4. Data from Files
###############################

df <- read.table("H:/introR/data/yeast/gene_relationships.txt",header=T,sep="\t")

#or mac 
df <- read.table("/Volumes/HOME/introR/data/yeast/gene_relationships.txt",header=T,sep="\t")

class(df)
df[1,]
df[,4]
df[2,7]
df[1:10,]
head(df)
df[1:3,1:4]

df$gene
df[,"gene"]

iv <- df[,4]=="YIL162W"
df[iv,]

df[df[,4] == "YIL162W", ]
df[df$left_gene_relationship == "overlapping",]

df[df$left_gene_dist > 5000 & df$right_gene_dist > 5000,]

df.sort <- df[order(df$chrom),]
#note, this will sort alphabetically chr1, chr10, chr11.

#sort by chromosome, then start.
df.sort <- df[order(df$chrom,df$start),]

#Find the means of a bunch of columns
colMeans(df[,c(8,11)])

#apply any function to columns (MARGIN=2) or rows (MARGIN=1) of a data frame
apply(df[,c(8,11)],MARGIN=2,FUN=median)
mylist <- list(c(1,2,3), "A thing", matrix(4,nrow=4,ncol=4),data.frame=df)
mylist[[1]]
mylist[[2]]
mylist[[3]]
mylist[[4]][1:10,]

df <- read.table("H:/introR/data/yeast/gene_relationships.txt",header=T,sep="\t",as.is=T)

###############################
# 5. Basic Plotting
###############################

weather <- read.csv("H:/introR/data/weather/us_weather.csv",as.is=T,strip.white=T)

#or mac
weather <- read.csv("/Volumes/HOME/introR/data/weather/us_weather.csv",as.is=T,strip.white=T)

fweather <- weather
fweather[,7:18] <- weather[,7:18]*9/5 + 32
dm.iv <- fweather[,1]=="DES MOINES"
dm <- fweather[dm.iv,]
dm[,"Oct"]

plot(dm[,"Period"],dm[,"Oct"])

plot(dm[,"Period"],dm[,"Oct"],main="October temperatures, Des Moines, 1878-2009",xlab="Year",ylab="Temp (degrees F)")

plot(dm[,"Period"],dm[,"Oct"],main="October temperatures, Des Moines, 1878-2009",xlab="Year",ylab="Temp (degrees F)",pch=20)
 
plot(dm[,"Period"],dm[,"Oct"],main="October temperatures, Des Moines, 1878-2009",xlab="Year",ylab="Temp (degrees F)",type="l")

iv <- dm$Period > 1900 & dm$Period < 2000

plot(lowess(dm[,"Period"][iv],dm[,"Oct"][iv],f=.1),main="Temperatures, Des Moines, 1900-2000",xlab="Year",ylab="Temp (degrees F)",type="l",ylim=c(10,70))

lines(lowess(dm[,"Period"][iv],dm[,"Nov"][iv],f=.1),col="blue")
lines(lowess(dm[,"Period"][iv],dm[,"Dec"][iv],f=.1),col="red")
lines(lowess(dm[,"Period"][iv],dm[,"Jan"][iv],f=.1),col="purple")

legend("topright",legend=c("Oct","Nov","Dec","Jan"),col=c("black","blue","red","purple"),lty=1)

hist(dm[,"Oct"])

hist(dm[,"Oct"],breaks=20)

hist(dm[,"Oct"],breaks=20,col="blue",main="October Temperatures, Des Moines, 1878-2009",xlab="Temp (degrees F)",ylab="Frequency")
 
hox <- read.table("H:/introR/data/hox/hox_qpcr.txt",sep="\t",header=T)

#or mac
hox <- read.table("/Volumes/HOME/introR/data/hox/hox_qpcr.txt",sep="\t",header=T)

colnames(hox) <- gsub("X","t",colnames(hox))
colnames(hox) <- tolower(colnames(hox))

hoxb1 <- hox[hox$gene == "Hoxb1",2:42]

barplot(as.matrix(hoxb1))
 
cols <- rainbow(13)
cols <- rep(rainbow(13),each=3)

barplot(t(hoxb1),col=cols,las=2,names.arg=colnames(hox)[2:42],beside=T,ylab="RQ",xlab="time (hours after RA)",main="Hoxb1 expression after RA induction",cex.names=.8)

###############################
# 6. For loops
###############################

head(hox)
for(i in 1:10)
{
	x11() #to open a new plot each time, otherwise they'll get overwritten
	barplot(t(hox[i, 2:42]), beside=T, las=2, names.arg=colnames(hox)[2:42], col=cols, main=hox[i,"gene"], cex.names=.8)
}

for(i in c(3,9,4,7))
{
	cat("The square of ",i," is ", i^2,".\n",sep="")
}
c(3,9,4,7)^2

cat(unlist(lapply(c(3,9,4,7),function(x) {paste("the square of ",x," is ",x^2,".\n",sep="")})))

###############################
# 7. Multifigure Plotting
###############################
#mfrow is expecting # of rows, # of columns
par(mfrow=c(2,2))
for(i in 1:4)
{
	barplot(t(hox[i,2:42]), beside=T, names.arg=colnames(hox)[2:42], col=cols, main=hox[i,"gene"],las=2,cex.names=.8)
}

###############################
# 8. Getting plots out of R
###############################

pdf("myplots.pdf")

#any plot you make here gets added to the pdf until the dev.off() function is called.

plot(x,y)

for(i in 1:length(hox[,1]))
{
	barplot(t(hox[i,2:42]), beside=T, names.arg=colnames(hox)[2:42], col=cols, main=hox[i,"gene"],las=2,cex.names=.8)
}

dev.off()

###############################
# 9. Boxplots
###############################

head(fweather)

boxplot(fweather[,7:18], main="Monthly Temperatures, USA")
boxplot(Jan~Station,data=fweather)
#calculate the average temperature in January for each Station, removing missing data
janavg <- tapply(fweather[,"Jan"],factor(fweather$Station),FUN=mean,na.rm=T)

#get the order of stations based on the January averages
coldToWarm <- names(janavg[order(janavg)])

#create a factor of the stations ordered by cold to warm
St <- factor(fweather$Station,levels=coldToWarm)

#set the margins so we can read the names
par(mar=c(9,3,3,3))

#make the boxplot, making labels perpendicular to axis, shrinking text size, adding colors from yellow to orange to red

boxplot(Jan~St,data=fweather,las=2,cex.axis=.6,main="Average January Temperatures by Station",col=colorRampPalette(c("yellow","orange","red"))(length(coldToWarm)))

###############################
# 10. Linear Regression
###############################
 
lm(dm$Oct~dm$Period)
model <- lm(dm$Oct~dm$Period)

class(model)
str(model)

plot(dm$Period,dm$Oct)
abline(lm(dm$Oct~dm$Period),col="blue")

head(dm)
dm$mn <- rowMeans(dm[,7:18],na.rm=T)

plot(dm$Period,dm$mn, main="Increasing mean temperatures in Des  Moines, 1878-2009",xlab="Year",ylab="Temperature (degrees F)")
abline(lm(dm$mn~dm$Period),col="blue")

meanmodel <- lm(dm$mn~dm$Period)
iv <- abs(meanmodel$resid)> 2

points(dm[iv,"Period"],dm$mn[iv], col="red")

dm[iv,]

###############################
# 11. Writing data out
###############################
write.table(dm[iv,],"data.txt",sep="\t",quote=F,row.names=F)

###############################
# 12. T-test
###############################

t.test(dm[dm$Period=="2008",7:18],dm[dm$Period=="2009",7:18])

tt<- t.test(dm[dm$Period=="2008",7:18],dm[dm$Period=="2009",7:18])
tt$p.value

###############################
# 13. Missing data
###############################

dm[is.na(dm)]
unlist(dm)[is.na(dm)]

###############################
# 14. Packages
###############################

install.packages("RColorBrewer")
source("http://bioconductor.org/biocLite.R")
biocLite("limma")

library("limma")

library()
sessionInfo()

help(package="limma")

###############################
# 15. Colors
###############################

hoxb1_avg <- aggregate(t(hoxb1),by=list(rep(1:14,each=3)[1:41]),mean)[,2]
names(hoxb1_avg)<-c("wt","t2","t4","t6","t8","t12_1","t12_2","t16","t24_1","t24_2","t36","t48","t60","t72")

length(hoxb1_avg)

mypal<-c("red","orange","yellow","green","blue","purple","darkblue","darkgreen","deeppink","darkorange","darkred","gold","hotpink","cyan")

barplot(hoxb1_avg,col=mypal,las=2,names.arg=names(hoxb1_avg),ylab="mean RQ",xlab="timepoint",main="Hoxb1 expression after RA induction",cex.names=.8)

cols <- colorRampPalette(c("yellow","orange","red"))(15)

barplot(hoxb1_avg,col=cols,las=2,names.arg=names(hoxb1_avg),ylab="mean RQ",xlab="timepoint",main="Hoxb1 expression after RA induction",cex.names=.8)

install.packages("RColorBrewer")
library(RColorBrewer)

display.brewer.all()

cols <- brewer.pal(9,"Set1")
barplot(hoxb1_avg,col=cols,las=2,names.arg=names(hoxb1_avg), ,ylab="mean RQ",xlab="timepoint",main="Hoxb1 expression after RA induction",cex.names=.8)

cols <- c(brewer.pal(9,"Set1"),brewer.pal(8,"Set2"))
barplot(hoxb1_avg,col=cols,las=2,names.arg=names(hoxb1_avg), ,ylab="mean RQ",xlab="timepoint",main="Hoxb1 expression after RA induction",cex.names=.8)

###############################
# 16. Heat maps
###############################

exp <- read.csv("H:/introR/data/mouse_ge/geneatlas_MOE430.csv",as.is=T)
names <- read.table("H:/introR/data/mouse_ge/moe4302.txt",as.is=T,header=T,sep="\t")

#or mac
exp <- read.csv("/Volumes/HOME/introR/data/mouse_ge/geneatlas_MOE430.csv",as.is=T)
names <- read.table("/Volumes/HOME/introR/data/mouse_ge/moe4302.txt",as.is=T,header=T,sep="\t")

selected <- exp[,c("MEF", "adipose_brown","adipose_white", "amygdala", "bladder", "bone", "bone_marrow", "cerebellum", "cerebral_cortex", "cornea", "heart", "iris", "kidney", "lens", "liver", "lung", "olfactory_bulb", "ovary", "pancreas", "pituitary", "placenta", "prostate", "retina", "salivary_gland", "skeletal_muscle", "spinal_cord", "spleen", "stomach", "testis", "umbilical_cord", "uterus")]

#setting the rownames to be probeset_id (gene_name)
rownames(selected)<-paste(exp[,1],"(",names[match(names[,1],exp[,1]),2],")")

#set the colors
cols <- brewer.pal(9,"Blues")

#create a heatmap with the first 1000 genes.
heatmap(as.matrix(selected[1:1000,]),col=cols,cexCol=.6,cexRow=.1) 

highest500.iv <- order(-rowMeans(selected))[1:500]
heatmap(as.matrix(selected[highest500.iv,]),col=cols,cexCol=.6,cexRow=.1)
