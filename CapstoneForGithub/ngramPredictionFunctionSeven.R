
ngramPredictionFunctionSeven <- function(input, con) { 
  
  out <- data.table(cur = c(" ", "  ", "   ", "    ", "     "), freq = rep(0,5)) # dummy output
  statement <- data.table(c( " 0 results" , " Sorry, no prediction. Please check your spelling. "))
  
      input <- gsub("[^a-zA-Z \']", "", input)
      input <- tolower(input)
      LastChar <- substring(input, nchar(input), nchar(input))    
      input <- NGramTokenizer(input, Weka_control(min = 1, max = 1, delimiters = " \\r\\n\\t.,;:\"()?!"))
      
      # lastChar is space?
      
      if (LastChar==" ") { # new word
          LastWord = paste("^",  character(0) , sep="")
      } else { # filter
          LastWord <- paste("^",  input[length(input)] , sep="")      
          input <- input[-length(input)]
      }
      
      # 4-gram
      if (length(input)>2) {
          txt <- paste(input[(length(input)-2):length(input)], collapse=" ")
          
          sql <- paste("SELECT cur, freq FROM four_grams WHERE ", 
                       "pre = '", paste(txt),"'", sep="")
          wd.list <- dbGetQuery(con, sql)
          
          # wd.list <- ngram4[x==txt, c(2,3), with = FALSE]
          wd.list <- wd.list[grep(LastWord, wd.list$cur),]
          wd.list$freq <- wd.list$freq /sum(wd.list$freq)*0.6
          out <- rbind(out, wd.list)
      }

      # 3-gram
      if (length(input)>1) {
          txt <- paste(input[(length(input)-1):length(input)], collapse=" ")
          
          sql <- paste("SELECT cur, freq FROM three_grams WHERE ", 
                       "pre = '", paste(txt),"'", sep="")
          wd.list <- dbGetQuery(con, sql)
          
          #wd.list <- ngram3[x==txt, c(2,3), with = FALSE]
          wd.list <-  wd.list[grep(LastWord, wd.list$cur),]
          wd.list$freq <- wd.list$freq /sum(wd.list$freq)*0.3
          out <- rbind(out, wd.list)
      }
      
      # 2-gram
      if (length(input)>0) {
          txt <- input[length(input)]
          
          sql <- paste("SELECT cur, freq FROM two_grams WHERE ", 
                       "pre = '", paste(txt),"'", sep="")
          wd.list <- dbGetQuery(con, sql)
          
          
          #wd.list <- ngram2[x==txt, c(2,3), with = FALSE]
          if (LastWord != "^") {wd.list <-  wd.list[grep(LastWord, wd.list$cur),]}
          wd.list$freq <- wd.list$freq /sum(wd.list$freq )*0.08
          wd.list <- wd.list[min(1,nrow(wd.list)):min(100,nrow(wd.list)),]          
          out <- rbind(out, wd.list)
      }
      
      # 1-gram
      
      a <- as.data.table( dbReadTable(con, "one_grams"))
      a<- a[, .(pre,freq)]
      names(a) <- c("cur","freq")
      
      wd.list <- a[grep(LastWord, a$cur),]
      
      #a<- dbReadTable(con, "one_grams")
      
      #wd.list <- a[grep(LastWord, a$y),]
     # wd.list <- ngram1[grep(LastWord, ngram1$y),]
      
      wd.list$freq <- wd.list$freq /sum(a$freq)*0.02
      wd.list <- wd.list[min(1,nrow(wd.list)):min(100,nrow(wd.list)),]
      
      words <- rbind(out, wd.list)
      #out <- rbind(out, wd.list)
    
      words <- words[, lapply(.SD, sum), by = c("cur")]
      #out <- out[, lapply(.SD, sum), by = c("cur")]
      
      words <- words[order(-words$freq),]
      #out <- out[order(-out$freq),]
      
      rownames(words) <- NULL
      #rownames(out) <- NULL
          
      out <- filter(words, freq >0)
      
      
      if ( nrow(out) >0 ){
        l<- min( nrow(out),5);
        
        return(head(out, n=l)) ;
        
      } else {
        
        return( statement) 
        
      } #return(head(out, n=5))

}
