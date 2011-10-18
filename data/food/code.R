library(XML)

x<-"Food_Display_Table.xml"

df<-xmlToDataFrame(x,colClasses=c("integer","character","numeric","numeric","character",rep("numeric",times=21)))

grain.iv<-which(df$Grains > .5)
wg.iv<-which(df$Whole_Grains > .5)
sv.iv<-which(df$Starchy_vegetables > .5)
f.iv<-which(df$Fruits > .5)
m.iv<-which(df$Milk > .5)
meat.iv<-which(df$Meats > .5)
s.iv<-which(df$Soy> .5)
b.iv<-which(df$Drybeans_Peas > .5)
o.iv<-which(df$Oils > .5)
f.iv<-which(df$Solid_Fats > .5)
veg.iv<-which(df$Vegetables > .5)

df2<-df[,c(2,3,5,25,26)]

plot(df2$Calories,df2$Saturated_Fats)
identify(df2$Calories,df2$Saturated_Fats,labels=df2[,1],col='red',cex=.7)

plot(df2$Calories[m.iv],df2$Saturated_Fats[m.iv])
identify(df2$Calories[m.iv],df2$Saturated_Fats[m.iv],labels=df2[m.iv,1],col='red',cex=.7)

plot(log2(df2$Calories[veg.iv]),log2(df2$Saturated_Fats[veg.iv]))
identify(log2(df2$Calories[veg.iv]),log2(df2$Saturated_Fats[veg.iv]),labels=df2[veg.iv,1],col='red',cex=.7)

write.table(df2,"food.txt",sep='\t',quote=F,row.names=F)
