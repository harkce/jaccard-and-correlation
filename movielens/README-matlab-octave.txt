
Example use of Movielens data in matlab/octave:

First, load the movielens data:

>> [ratings items userids itemids] = loadmovielens();

Then you can try out the demo code (in demo.m) as follows

>> demo( ratings, items, userids, itemids, 0 );
>> demo( ratings, items, userids, itemids, 1 );
>> demo( ratings, items, userids, itemids, 2 );

Please see the code for details of what these different calls do, and
also look at the implementations to see how they are done.

