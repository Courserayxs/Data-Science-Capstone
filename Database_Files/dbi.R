pkgs1 =c('tools','DBI','RSQLite')
pkgs2= c('ggplot2','reshape2','tm','qdap','dplyr', 'slam','data.table', 'RWeka')


install.packages(pkgs2)

inst=lapply(pkgs1, library, character.only=TRUE)

options(mc.cores=1)

source('utility.R');  source('SampleTextData.R')

###############################################################################################################3
twitter <- readTextFile('./data/en_US/en_US.twitter.txt',"UTF-8")
blogs <- readTextFile('./data/en_US/en_US.blogs.txt',"UTF-8" )
news <- readTextFile('./data/en_US/en_US.news.txt', "UTF-8")

########################################################################################################3
twitter.s <- sampleTextData(twitter, .02)
blogs.s <- sampleTextData(blogs, .02)
news.s <- sampleTextData(news, .02)

rm(list=c('twitter','blogs','news'))

##############################################################################################################
tCorp <- getCorpus2(twitter.s)
bCorp <- getCorpus2(blogs.s)
nCorp <- getCorpus2(news.s)

rm(list=c('twitter.s','blogs.s','news.s'))
##################################################################################################################


UnigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
QuadgramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))


#################################################################################################################

tTdm_2 <- TermDocumentMatrix(tCorp, control = list(tokenize = BigramTokenizer)) 
tTdm_3 <- TermDocumentMatrix(tCorp, control = list(tokenize = TrigramTokenizer))
tTdm_4 <- TermDocumentMatrix(tCorp, control = list(tokenize = QuadgramTokenizer))

bTdm_1 <- TermDocumentMatrix(bCorp, control = list( tokenize= UnigramTokenizer))
bTdm_2 <- TermDocumentMatrix(bCorp, control = list(tokenize = BigramTokenizer)) 
bTdm_3 <- TermDocumentMatrix(bCorp, control = list(tokenize = TrigramTokenizer))
bTdm_4 <- TermDocumentMatrix(bCorp, control = list(tokenize = QuadgramTokenizer))

nTdm_2 <- TermDocumentMatrix(nCorp, control = list(tokenize = BigramTokenizer)) 
nTdm_3 <- TermDocumentMatrix(nCorp, control = list(tokenize = TrigramTokenizer))
nTdm_4 <- TermDocumentMatrix(nCorp, control = list(tokenize = QuadgramTokenizer))

rm(tCorp,bCorp,nCorp)

##################################################################################################3
bFreq_1 <- tdmToFreq(bTdm_1)

tFreq_2 <- tdmToFreq(tTdm_2)
nFreq_2 <- tdmToFreq(nTdm_2)
bFreq_2 <- tdmToFreq(bTdm_2)


tFreq_3 <- tdmToFreq(tTdm_3)
nFreq_3 <- tdmToFreq(nTdm_3)
bFreq_3 <- tdmToFreq(bTdm_3)

tFreq_4 <- tdmToFreq(tTdm_4)
nFreq_4 <- tdmToFreq(nTdm_4)
bFreq_4 <- tdmToFreq(bTdm_4)

processGram(tFreq_4)
processGram(nFreq_4)
processGram(bFreq_4)

rm(bTdm_4,bTdm_3,bTdm_2, nTdm_4, nTdm_3, nTdm_2, tTdm_4, tTdm_3, tTdm_2)
########################################################################################################
processGram(bFreq_1)




processGram(nFreq_2)
processGram(bFreq_2)

tFreq_2[, c("pre", "cur"):=list(unlist(strsplit(word, "[ ]+?[a-z]+$")), 
                                unlist(strsplit(word, "^([a-z]+[ ])+"))[2]), 
        by=word]
head(tFreq_2)
de_max <- max(tFreq_2[pre=="right"]$freq)
tFreq_2[pre == "right" & freq == de_max]

processGram(nFreq_3)
processGram(bFreq_3)

tFreq_3[, c("pre", "cur"):=list(unlist(strsplit(word, "[ ]+?[a-z]+$")), 
                                unlist(strsplit(word, "^([a-z]+[ ])+"))[2]), 
        by=word]

de_max_3 <- max(tFreq_3[pre == "happy birthday"]$freq)
tFreq_3[pre == "happy birthday" & freq == de_max_3]


#####################################################################################################
dtnFreq_2 <- as.data.table(nFreq_2 )
dtbFreq_1 <- as.data.table(bFreq_1 )
dttFreq_4 <- as.data.table(tFreq_4 )

###########################################################################################
dtnFreq_2 <- dtnFreq_2[, .(pre,cur,freq)]
dtbFreq_1 <- dtbFreq_1[, .(pre,cur,freq)]
dttFreq_4 <- dttFreq_4[, .(pre,cur,freq)]

dtbFreq_1 <- dtbFreq_1[, .(pre, freq)]
head(dttFreq_4) head(dttFreq_3) head(dtnFreq_2) head(dtbFreq_1)

######################################################################################
#You must repeat the following with one_grams, two_grams, three_grams, four_grams 
##############################################################################

db <- dbConnect(SQLite(), dbname="train.db")
dbSendQuery(conn=db,
            "CREATE TABLE one_grams
            (pre TEXT,
            cur TEXT,
            freq INTEGER )")  # ROWID automatically created with SQLite dialect

sql_t1 <- "INSERT INTO one_grams VALUES ($pre, $cur, $freq)"
bulk_insert(sql_t1, dtbFreq_1)




#####################################################################################################3333

qCorp <- quanteda::corpus(tCorp)

quanteda::kwic(qCorp, ' i have')


