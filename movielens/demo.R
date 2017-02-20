
# STARTING UP:
#
# > source('sourcedir.R')
# > sourceDir('./')
# > loadmovielens()
# > demo(task)
#

demo <- function( task ) {

  #------------------------------------------------------------------------
  # Task 0: Show a random user profile
  #------------------------------------------------------------------------

  if (task==0) {
	
    useseconds <- TRUE
    uid <- sample(userids,1)
    showuser(uid,useseconds)
    
  }  

  #------------------------------------------------------------------------
  # Task 1: Compute movies with most/fewest ratings
  #------------------------------------------------------------------------

  if (task==1) {

    cnt <- table(ratings[,2])
    cntindices <- as.numeric(names(cnt))
	
    si <- sort.int(cnt,decreasing=TRUE,index.return=TRUE)
    rowperm <- si$ix
	
    cat('Top 10 items:\n')
    for (i in 1:10)
    {
      cat('[',i,'] Cnt: ',cnt[rowperm[i]],'  ',
          items[which(items[,1]==rowperm[i]),2],'\n',sep='')	
    }	

    cat('Bottom 10 items:\n')
    for (i in (length(rowperm)-9):(length(rowperm)-0))
    {
      cat('[',i,'] Cnt: ',cnt[rowperm[i]],'  ',
          items[which(items[,1]==rowperm[i]),2],'\n',sep='')	
    }	
    
  }  

  #------------------------------------------------------------------------
  # Task 2: Compute movies with highest/lowest average
  # (require 'mincnt' ratings to avoid movies with very few ratings)
  #------------------------------------------------------------------------

  if (task==2) {

    mincnt <- 10
		
    avg <- round(tapply(ratings[,3],ratings[,2],mean),2)
    avgindices <- as.numeric(names(avg))
    cnt <- table(ratings[,2])
    cntindices <- as.numeric(names(cnt))
    
    sufficient <- which(cnt>=mincnt)
    ids <- avgindices[sufficient]
    cnt <- cnt[sufficient]
    avg <- avg[sufficient]
    
    si <- sort.int(avg,decreasing=TRUE,index.return=TRUE)
    rowperm <- si$ix
    
    cat('Top 10 items:\n')
    for (i in 1:10)
    {
      cat('[',i,'] Avg: ',format(avg[rowperm[i]],nsmall=2),
          ' Cnt: ',cnt[rowperm[i]],'  ',
          items[which(items[,1]==ids[rowperm[i]]),2],'\n',sep='')	
    }	
    
    cat('Bottom 10 items:\n')
    for (i in (length(ids)-9):(length(ids)-0))
    {
      cat('[',i,'] Avg: ',format(avg[rowperm[i]],nsmall=2),
          ' Cnt: ',cnt[rowperm[i]],'  ',
          items[which(items[,1]==ids[rowperm[i]]),2],'\n',sep='')	
    }	
    
  }  

  

}

