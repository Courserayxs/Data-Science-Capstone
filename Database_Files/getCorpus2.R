#pkgs2= c('ggplot2','reshape2','tm','qdap','dplyr', 'slam','data.table', 'RWeka')


#install.packages(pkgs2)
#inst=lapply(pkgs2, library, character.only=TRUE)
#####################################################################################################################33
getCorpus2 <- function(v) {
  
  
  corpus <- iconv(v,"latin1","ASCII",sub="'")
  
  # Processes a vector of documents into a tm Corpus
  corpus <- Corpus(VectorSource(v))
  corpus <- tm_map(corpus, stripWhitespace)  # remove whitespace
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  # replace contraction with full form
  corpus <- tm_map(corpus,content_transformer(replace_contraction))
  
  # replace abbreviation with full form
  corpus <- tm_map(corpus,content_transformer(replace_abbreviation))
  
  # Remove text which is within brackets
  corpus <- tm_map(corpus,content_transformer(bracketX))
  
  corpus <- tm_map(corpus, content_transformer(tolower))  # lowercase all
  # corpus <- tm_map(corpus, removeWords, stopwords("english"))  # rm stopwords
  
  corpus 
}