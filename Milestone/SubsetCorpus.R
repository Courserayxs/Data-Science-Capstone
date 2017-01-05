SubsetCorpus<- function(x,p) { 
  
  lapply(x,function(y,p){
    
    l<-sample(y[[1]], size =round(p*length(y[[1]])));
    
    return(l) },p=p)
  
}

