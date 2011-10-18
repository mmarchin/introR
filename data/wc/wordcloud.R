require(wordcloud)
require(tm)

(t<- Corpus(DirSource("oos"), readerControl = list(language = "eng")))

mycorpus <- tm_map(t, removePunctuation)
mycorpus <- tm_map(mycorpus, tolower)
mycorpus <- tm_map(mycorpus, function(x)removeWords(x,stopwords("english")))
tdm <- TermDocumentMatrix(mycorpus)
m <- as.matrix(tdm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)

#organic carrot palette
pal<-c("#5C6E00","#273B00","#F7DA00","#EB1200","#F78200")

wordcloud(d$word,d$freq,scale=c(6,.5),min.freq=2,max.words=100,random.order=FALSE,rot.per=.20,random.color=T,colors=pal)


#q   <- "db=pubmed&term=saunders+nf[au]&usehistory=y"
#q   <- "db=pubmed&term=gogol+madelaine[au]&usehistory=y"
#q   <- "db=pubmed&term=oct4[title]&usehistory=y"


library(RCurl)
library(XML)
library(RColorBrewer)
library(wordcloud)
library(tm)

# esearch
url <- "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?"
q   <- "db=pubmed&term=Stowers[affiliation]&usehistory=y"
#q   <- "db=pubmed&term=Sox2[title]&usehistory=y"
esearch <- xmlTreeParse(getURL(paste(url, q, sep="")), useInternal = T)
webenv  <- xmlValue(getNodeSet(esearch, "//WebEnv")[[1]])
key     <- xmlValue(getNodeSet(esearch, "//QueryKey")[[1]])

# efetch
url <- "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?"
q   <- "db=pubmed&retmode=xml&rettype=abstract"
efetch <- xmlTreeParse(getURL(paste(url, q, "&WebEnv=", webenv, "&query_key=", key, sep="")), useInternal = T)
abstracts <- getNodeSet(efetch, "//AbstractText")

# words
abstracts <- sapply(abstracts, function(x) { xmlValue(x) } )
words <- tolower(unlist(lapply(abstracts, function(x) strsplit(x, " "))))


mycorpus<-Corpus(VectorSource(sample(words,20000)))
mycorpus<-tm_map(mycorpus,removePunctuation)
mycorpus<-tm_map(mycorpus,function(x)removeWords(x,stopwords("english")))
mycorpus<-tm_map(mycorpus,tolower)
tdm<-TermDocumentMatrix(mycorpus)
m<-as.matrix(tdm)
v<-sort(rowSums(m),decreasing=TRUE)
d<-data.frame(word=names(v),freq=v)
pal<-brewer.pal(9,"PuBuGn")
wordcloud(d$word,d$freq,scale=c(4,.5),min.freq=2,max.words=70,random.order=FALSE,rot.per=.20,random.color=F,colors=pal)

pal<-c("#5C6E00","#273B00","#F7DA00","#EB1200","#F78200")
wordcloud(d$word,d$freq,scale=c(4,.5),min.freq=2,max.words=100,random.order=FALSE,rot.per=.20,random.color=T,colors=pal)
