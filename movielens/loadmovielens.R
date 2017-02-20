#
# loadmovielens()
#
# Loads the movielens 100k dataset from the 'data' subdirectory
# and puts it in the following global variables:
#
# ratings: each rows is (userID, itemID, rating, timestamp)
# items: each row is (itemID, title)
# userids: 1:943
# itemids: 1:1682
#

loadmovielens <- function() {

  cat('Reading the Movielens data into globals...\n')

  # Path and file names
  pathname <- 'data/'
  ratingsfname <- 'u.data'
  itemsfname <- 'u.item'
	
  # Read the ratings
  cat('  Reading the ratings...')
  ratings <<- read.table(paste(pathname,ratingsfname,sep=''),sep="\t")
  cat('Done!\n')
		
  # Get user and item id's (hardcoded here for simplicity)
  userids <<- 1:943
  itemids <<- 1:1682
	  
  # Read the movies titles
  cat('  Reading the movie titles...')
  items <<- read.table(paste(pathname,itemsfname,sep=''),
	                             sep="|",as.is=TRUE,quote="")
  items <<- items[,1:2]	                       
  cat('Done!\n')	

  cat('  Total users:',length(userids),'\n')
  cat('  Total items:',length(itemids),'\n')
  cat('  Total ratings:',dim(ratings)[1],'\n')
  Nmov <- length(itemids)
  Nusr <- length(userids)
  cat('  Denseness:',dim(ratings)[1]/(Nmov*Nusr),'\n')
  	
  cat('Done reading the Movielens data into globals!\n')
  
}
