
readTextFile <- function(fileName,encoding){
  
  # Open file in binary mode
  con <- file(fileName,'rb')
  
  # I used skipnul because in twitter dataset there are few nulls
  data <- readLines(con,encoding = encoding,skipNul = T)
  
  # Close connection
  close(con)
  
  # Return the data
  return(data)
}




sampleTextData <- function(data,proportion){
  
  # Rbinom function is used to sample data
  # It will return data as per proportion argument
  return(data[as.logical(rbinom(length(data),1,proportion))])
}