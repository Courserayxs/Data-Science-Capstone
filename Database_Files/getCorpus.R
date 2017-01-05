# Utility Functions
library(magrittr)
library(data.table)
library(RWeka)
getCorpus <- function(v) {
  # Processes a vector of documents into a tm Corpus
  corpus <- VCorpus(VectorSource(v))
  corpus <- tm_map(corpus, stripWhitespace)  # remove whitespace
  
  
  # Remove text which is within brackets
  corpus <- tm_map(corpus,content_transformer(bracketX))
  
  
  corpus <- tm_map(corpus, content_transformer(tolower))  # lowercase all
  # corpus <- tm_map(corpus, removeWords, stopwords("english"))  # rm stopwords
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus 
}