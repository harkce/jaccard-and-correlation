
Example use of movielens data in R

First, source all the .R files in the directory:

> source("sourcedir.R")
> sourceDir("./")

Next, load the movielens data (creates the global variables
'ratings','items','userids',and 'itemids' to hold the data)

> loadmovielens()

Then you can try out the demo code (in demo.R) as follows

> demo(0)
> demo(1)
> demo(2)

Please see the code for details of what these different calls do, and
also look at the implementations to see how they are done.

