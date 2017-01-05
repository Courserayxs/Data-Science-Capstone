cleanTextData <- function(data){
  
  # Remove non english characters
  data.cleaned <- iconv(data,"latin1","ASCII",sub="'")
  
  # Create corpus of data
  corpus <- Corpus(VectorSource(list(data.cleaned)))
  
  # Remove numbers from the data
  corpus.cl <- tm_map(corpus,removeNumbers)
  
  # replace contraction with full form
  corpus.cl <- tm_map(corpus.cl,content_transformer(replace_contraction))
  
  # replace abbreviation with full form
  corpus.cl <- tm_map(corpus.cl,content_transformer(replace_abbreviation))
  
  # Remove text which is within brackets
  corpus.cl <- tm_map(corpus.cl,content_transformer(bracketX))
  
  # Remove punctuation from the data
  corpus.cl <- tm_map(corpus.cl,removePunctuation)
  
  # Convert all data to lower case
  corpus.cl <- tm_map(corpus.cl,content_transformer(tolower))
  
  # Strip whitespaces from the data
  corpus.cl <- tm_map(corpus.cl, stripWhitespace)
  
  return(corpus.cl)
}