showuser <- function( userid, useseconds )
{

	# Find all ratings by this user
	selectedrows <- which(ratings[,1] == userid)
	ys <- ratings[selectedrows,]
	
	if (useseconds)
	{
	  newvec <- rep(0,dim(ys)[1])
	  for (i in (1:dim(ys)[1]))
	  {
	    timestamp <- ys[i,4]
	    newvec[i] <- unclass(as.Date(substr(ISOdate(1970,1,1)+timestamp,1,10)))
	  }
	  ys[,4] <- newvec
	  useseconds <- FALSE
	}
	
	# If there is only a single rating then:
	if (length(selectedrows)==-1)
	{
	  cat('UserID:',userid,'\n')
	  cat('Score Movie\n')
	  cat(' ',ratings[selectedrows,3],' ',sep='')
	  timestamp <- ratings[selectedrows,4]
	  if (is.numeric(timestamp))
	  {
	    if (useseconds)
	    {
	      timestamp <- substr(ISOdate(1970,1,1)+timestamp,1,10)
	      cat(' ',timestamp,sep='')
	    }
	    else
	    {
	      class(timestamp) <- "Date"
	      cat(' ',format(timestamp),sep='')
	    }
	  }
	  cat(' ',ratings[selectedrows,2],'\n',sep='')	    
	  return(0)
	}
	
	# Order these by the timestamp
	si <- sort.int(ys[,4],decreasing=FALSE,index.return=TRUE)
	rowperm <- si$ix
	ys <- ys[rowperm,]

	# Replace the movie id with the title	
	for (i in 1:dim(ys)[1])
	{
	  ys[i,2] <- items[which(items[,1]==ys[i,2]),2]
	}

	# Print everything nicely
	cat('UserID:',userid,'\n')
	cat('UserID Score Date Movie\n')
	for (i in 1:dim(ys)[1])
	{

	  timestamp <- ys[i,4]		
	  cat(userid,' ',sep='')

	  {
	    cat('  ',ys[i,3],'  ',sep='')
	  }
	  
	  if (useseconds)
	  {
	    timestamp <- substr(ISOdate(1970,1,1)+timestamp,1,10)
	    cat(' ',timestamp,sep='')
	  }
	  else
	  {
	    class(timestamp) <- "Date"
	    cat(' ',format(timestamp),sep='')
	  }
	  cat(' ',ys[i,2],'\n',sep='')	    
	  
	}
	
	cat('Total of ',dim(ys)[1],' ratings.\n',sep='')
}

