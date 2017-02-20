function showuser( ratings, items, userids, itemids, uid )
% showuser - shows all ratings of a random user
%

  % Find all ratings by this user
  selectedrows = find(ratings(:,1) == uid);
  ys = ratings(selectedrows,:);
		
  % Print everything nicely
  fprintf(1,'UserID: %d\n',uid);
  fprintf(1,'UserID Score Movie\n');
  for (i = 1:length(selectedrows))
    fprintf(1,'%d  %d     ',ys(i,1),ys(i,3));
    fprintf(1,items{ys(i,2)});
    fprintf(1,'\n');
  end
	
  fprintf(1,'Total of %d ratings.\n',length(selectedrows));



