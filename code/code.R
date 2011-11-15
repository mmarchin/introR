###########################
# 1. Getting Started
###########################

#windows
dir.create("H:/introR")
file.copy(from="U:/mcm/presentations/CompTools/introR/data",to="H:/introR",recursive=T)
file.copy(from="U:/mcm/presentations/CompTools/introR/code/code.R",to="H:/introR")
file.copy(from="U:/mcm/presentations/CompTools/introR/introR.docx",to="H:/introR")
setwd("H:/introR")

#or mac
dir.create("/Volumes/HOME/introR")
file.copy(from="/Volumes/projects/mcm/presentations/CompTools/introR/data",to="/Volumes/HOME/introR",recursive=T)
file.copy(from="/Volumes/projects/mcm/presentations/CompTools/introR/code/code.R",to="/Volumes/HOME/introR")
file.copy(from="/Volumes/projects/mcm/presentations/CompTools/introR/introR.docx",to="/Volumes/HOME/introR")
setwd("/Volumes/HOME/introR")

?mean
help.start()

###########################
# 2. R as a calculator
###########################
1+1
100-20
4*6
10^2
100/4
sqrt(2)
log2(2) 
?log2

###########################
# 3. Variables
###########################
num <- 2
num

n <- 7.45

###########################
# 4. Vectors
###########################
c(1,3,6,13,8)
x <- c(1,3,6,13,8)
x

#create another vector, y.
y <- c(2,5,4,12,7)
y

x[5]

vector1 <- c("hi","how","are","you")

1:10
values <- 1:10

mean(x)
median(x)
min(y)
max(y)

which(x==6)

#you can also use greater than (>), less than (<), greater than or equal to (>=), or less than or equal to (>=).
which(x<3)

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
 
###########################
# 5. Data from Files
###########################
yeast <- read.table("H:/introR/data/yeast/gene_relationships.txt",header=T,sep="\t",as.is=T)
#or mac 
yeast <- read.table("/Volumes/HOME/introR/data/yeast/gene_relationships.txt",header=T,sep="\t")

yeast[1,]
yeast[,4]
yeast[2,7]

#first 10 lines
yeast[1:10,]

#head() is a special function to view the first 6 lines of a data frame.
head(yeast)

colnames(yeast)

#setting the row names to the gene names
rownames(yeast) <- yeast$gene

yeast$gene
yeast[,"gene"]

yeast[,c("gene","chrom")]

iv <- yeast[,4]=="YIL162W"
yeast[iv,]

iv <- yeast$left_gene_relationship == "overlapping"
sub <- yeast[iv,]

sub <- yeast[yeast$left_gene_relationship == "overlapping",]

yeast.sort <- yeast[order(yeast$chrom),]

#Find the means of two columns
colMeans(yeast[,c(8,11)])

#apply any function (here median) to columns (MARGIN=2) or rows (MARGIN=1) of a data frame
apply(yeast[,c(8,11)],MARGIN=2,FUN=median)

###########################
# 6. Basic Plotting
###########################
weather <- read.csv("H:/introR/data/weather/us_weather.csv",as.is=T,strip.white=T)
#or mac
weather <- read.csv("/Volumes/HOME/introR/data/weather/us_weather.csv",as.is=T,strip.white=T)

fweather <- weather
fweather[,7:18] <- weather[,7:18] * 9/5 + 32

boston.iv <- fweather[,1]=="BOSTON"
boston <- fweather[boston.iv,]

plot(boston[,"Period"],boston[,"Oct"])

plot(boston[,"Period"],boston[,"Oct"],main="October temperatures, Boston, 1871-2008",xlab="Year",ylab="Temp (degrees F)")
 
plot(boston[,"Period"],boston[,"Oct"],main="October temperatures, Boston, 1871-2008",xlab="Year",ylab="Temp (degrees F)",pch=20)
 
plot(boston[,"Period"],boston[,"Oct"],main="October temperatures, Boston, 1871-2008",xlab="Year",ylab="Temp (degrees F)",type="l")
 
plot(lowess(boston[,"Period"],boston[,"Oct"],f=.1),main="Temperatures, Boston, 1871-2008",xlab="Year",ylab="Temp (degrees F)",type="l",ylim=c(10,70))
lines(lowess(boston[,"Period"],boston[,"Nov"],f=.1),col="blue")
lines(lowess(boston[,"Period"],boston[,"Dec"],f=.1),col="red")
lines(lowess(boston[,"Period"],boston[,"Jan"],f=.1),col="purple")
lines(lowess(boston[,"Period"],boston[,"Feb"],f=.1),col="green")
legend("topright",legend=c("Oct","Nov","Dec","Jan","Feb"),col=c("black","blue","red","purple","green"),lty=1)

#histograms
hist(boston[,"Oct"])
hist(boston[,"Oct"],breaks=20)
hist(boston[,"Oct"],breaks=20,col="blue",main="October Temperatures, Boston, 1871-2008",xlab="Temp (degrees F)",ylab="Frequency")
  
#barplots
hox <- read.table("H:/introR/data/hox/hox_qpcr.txt",sep="\t",header=T)
#or mac
hox <- read.table("/Volumes/HOME/introR/data/hox/hox_qpcr.txt",sep="\t",header=T)

hoxb1 <- hox[hox$gene == "Hoxb1",2:42]
barplot(hoxb1)
class(hoxb1)
barplot(as.matrix(hoxb1))
 
cols <- rainbow(13)
cols <- rep(rainbow(13),each=3)
#if we look at cols, we see the hex values of colors each repeated 3 times.
cols
barplot(t(hoxb1),col=cols,las=2,names.arg=colnames(hox)[2:42],beside=T,ylab="RQ",xlab="time (hours after RA)",main="Hoxb1 expression after RA induction",cex.names=.8)

###########################
# 7. For loops
###########################
#take a look at the first 6 rows
head(hox)

for(i in 1:10)
{
	#if you're not using Rstudio, put x11() here to make sure your plots aren't overwritten.
	barplot(t(hox[i, 2:42]), beside=T, las=2, names.arg=colnames(hox)[2:42], col=cols, main=hox[i,"gene"], cex.names=.8)
}

for(i in c(3,9,4,7))
{
	cat("The square of ",i," is ", i^2,".\n",sep="")
}
cat(unlist(lapply(c(3,9,4,7),function(x) {paste("the square of ",x," is ",x^2,".\n",sep="")})))

###########################
# 8. Multifigure Plotting
###########################
#mfrow stands for multi-figure row, and is expecting number of rows, then number of columns
par(mfrow=c(2,2))
for(i in 1:4)
{
	barplot(t(hox[i,2:42]), beside=T, names.arg=colnames(hox)[2:42], col=cols, main=hox[i,"gene"],las=2,cex.names=.8)
}

###########################
# 9. Getting plots out of R
###########################
pdf("myplots.pdf")
#any plot you make here gets added to the pdf until the dev.off() function is called.
plot(x,y)
for(i in 1:length(hox[,1]))
{
	barplot(t(hox[i,2:42]), beside=T, names.arg=colnames(hox)[2:42], col=cols, main=hox[i,"gene"],las=2,cex.names=.8)
}
dev.off()

###########################
# 10. Boxplots
###########################
head(fweather)
boxplot(fweather[,7:18], main="Monthly Temperatures, USA")

###########################
# 11. Linear Regression
###########################
lm(boston$Oct~boston$Period)
model <- lm(boston$Oct~boston$Period)

class(model)

str(model)

plot(boston$Period,boston$Oct)
#abline() is a function to add a line to a plot given y-intercept and slope
#abline() can also do horiz and vert lines, look at ?abline). 
abline(lm(boston$Oct~boston$Period),col="blue")
 
model <- lm(boston$Oct~boston$Period)
iv <- abs(model$resid) > 3
plot(boston$Period,boston$Oct)
abline(lm(boston$Oct~boston$Period),col="blue")
points(boston$Period[iv],boston$Oct[iv], col="red")
 
boston[iv,]

###########################
# 12. Writing data out
###########################
write.table(boston[iv,],file="outliers.txt",sep="\t",quote=F,row.names=F)

###########################
# 13. T-test
###########################
t.test(boston$Oct,boston$Nov)
tt <- t.test(boston$Oct,boston$Nov)
tt$p.value
[1] 1.098882e-82

###########################
# 14. Packages
###########################
install.packages("RColorBrewer")
source("http://bioconductor.org/biocLite.R")

biocLite("limma")
library("limma")

library()

sessionInfo()
help(package="limma")

###########################
# 15. Colors
###########################
hoxb1_avg <- aggregate(t(hoxb1),by=list(rep(1:14,each=3)[1:41]),mean)[,2]
names(hoxb1_avg)<-c("wt","t2","t4","t6","t8","t12_1","t12_2","t16","t24_1","t24_2","t36","t48","t60","t72")
length(hoxb1_avg)

mypal<-c("red","orange","yellow","green","blue","purple","darkblue","darkgreen","deeppink","darkorange","darkred","gold","hotpink","cyan")
barplot(hoxb1_avg,col=mypal,las=2,names.arg=names(hoxb1_avg),ylab="mean RQ",xlab="timepoint",main="Hoxb1 expression after RA induction",cex.names=.8)
 
cols <- colorRampPalette(c("yellow","orange","red"))(14)
barplot(hoxb1_avg,col=cols,las=2,names.arg=names(hoxb1_avg),ylab="mean RQ",xlab="timepoint",main="Hoxb1 expression after RA induction",cex.names=.8)
 
install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all()
cols <- brewer.pal(9,name="Set1")
barplot(hoxb1_avg,col=cols, las=2, names.arg=names(hoxb1_avg), ylab="mean RQ", xlab="timepoint", main="Hoxb1 expression after RA induction", cex.names=.8)
 
###########################
# 16. Heat maps
###########################
exp <- read.csv("H:/introR/data/mouse_ge/geneatlas_MOE430.csv",as.is=T)
names <- read.table("H:/introR/data/mouse_ge/moe4302.txt",as.is=T,header=T,sep="\t")
#or mac
exp <- read.csv("/Volumes/HOME/introR/data/mouse_ge/geneatlas_MOE430.csv",as.is=T)
names <- read.table("/Volumes/HOME/introR/data/mouse_ge/moe4302.txt",as.is=T,header=T,sep="\t")

selected <- exp[,c("MEF", "adipose_brown","adipose_white", "amygdala", "bladder", "bone", 
"bone_marrow", "cerebellum", "cerebral_cortex", "cornea", "heart", "iris", "kidney", "lens", "liver", "lung", "olfactory_bulb", "ovary", "pancreas", "pituitary", "placenta", "prostate", "retina", "salivary_gland", "skeletal_muscle", "spinal_cord", "spleen", "stomach", "testis", "umbilical_cord", "uterus")]

#setting the rownames to be probeset_id (gene_name)
rownames(selected)<-paste(exp[,1],"(",names[match(names[,1],exp[,1]),2],")")

#create the heatmap
heatmap(as.matrix(selected[1:1000,]), cexCol=.6, cexRow=.3)
 
#change the colors
cols <- brewer.pal(9,"Blues")
heatmap(as.matrix(selected[1:1000,]), col="blue", cexCol=.6, cexRow=.3)
 
highest500.iv <- order(-rowMeans(selected))[1:500]
heatmap(as.matrix(selected[highest500.iv,]),col=cols,cexCol=.6,cexRow=.3)
 
###########################
# For your consideration
###########################

#missing values
boston[is.na(boston)]
unlist(boston)[is.na(boston)]

#lists
mylist <- list(c(1,2,3), "A thing", matrix(4,nrow=4,ncol=4), data.frame=yeast)
mylist[[1]]
mylist[[2]]
mylist[[3]]
mylist[[4]][1:10,]
