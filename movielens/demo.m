function demo( ratings, items, userids, itemids, task )
% demo - examples of how to work with the Movielens data
%
% Before calling this function, call loadmovielens() as follows:
% [ratings items userids itemids] = loadmovielens();
%
    
  more off;  
    
  %------------------------------------------------------------------------
  % Task 0: Show a random user profile
  %------------------------------------------------------------------------

  if (task==0),
	
    useseconds = 1;
    uid = floor(rand*max(userids))+1;
    showuser( ratings, items, userids, itemids, uid );
    
  end

  %------------------------------------------------------------------------
  % Task 1: Compute movies with most/fewest ratings
  %------------------------------------------------------------------------

  if (task==1),

    cnt = hist(ratings(:,2),max(itemids));
    
    [dummy,si] = sort(-cnt);
	
    fprintf(1,'Top 10 items:\n');
    for (i = 1:10),
      fprintf(1,'[%d] Cnt: %d  ',i,cnt(si(i)));
      fprintf(1,items{si(i)});
      fprintf(1,'\n');
    end

    fprintf(1,'Bottom 10 items:\n');
    N = max(itemids);
    for (i = (N-9):N),
      fprintf(1,'[%d] Cnt: %d  ',i,cnt(si(i)));
      fprintf(1,items{si(i)});
      fprintf(1,'\n');
    end

  end

  %------------------------------------------------------------------------
  % Task 2: Compute movies with highest/lowest average
  % (require 'mincnt' ratings to avoid movies with very few ratings)
  %------------------------------------------------------------------------

  if (task==2),

    mincnt = 10;
	
    N = max(itemids);
    sums = zeros(1,N);
    for (i=1:length(ratings))
	ind = ratings(i,2);
	sums(ind) = sums(ind)+ratings(i,3);
    end
    cnt = hist(ratings(:,2),max(itemids));
    avg = sums./cnt;
    avg = round(avg*100)/100;
    
    suff = find( cnt>=mincnt );
    cnt = cnt( suff );
    avg = avg( suff );
    
    [dummy,si] = sort(-avg);

    fprintf(1,'Top 10 items:\n');
    for (i = 1:10),
      fprintf(1,'[%d] Avg: %.2f Cnt: %d  ',i,avg(si(i)),cnt(si(i)));
      fprintf(1,items{suff(si(i))});
      fprintf(1,'\n');
    end

    fprintf(1,'Bottom 10 items:\n');
    N = length(suff);
    for (i = (N-9):N),
      fprintf(1,'[%d] Avg: %.2f Cnt: %d  ',i,avg(si(i)),cnt(si(i)));
      fprintf(1,items{suff(si(i))});
      fprintf(1,'\n');
    end
    
  end

end
