function [ratings items userids itemids] = loadmovielens()
% loadmovielens - loads the movielens data
%
% SYNTAX:
% [ratings items userids itemids] = loadmovielens();
%
% The function returns:
% ratings: each rows is (userID, itemID, rating, timestamp)
% items: the titles of the movie (items(itemID) = 'title')
% userids: 1:943
% itemids: 1:1682
%

more off;
fprintf(1,'Reading the Movielens data...\n');

% Path and file names
pathname = 'data/';
ratingsfname = 'u.data';
itemsfname = 'u.item';

% Read in the ratings
ratings = load([pathname ratingsfname]);

% Read in the items
fid = fopen([pathname itemsfname]);
items = {};
items{1682} = '';
for i=1:1682
    items{i} = fgetl(fid);
    pos = strfind(items{i},'|');
    items{i} = items{i}((pos(1)+1):(pos(2)-1));
end
fclose(fid);

% User and movie indices (not really needed for this data
% since indices go linearly from 1 to max in both cases)
userids = 1:943;
itemids = 1:1682;

fprintf(1,'Done!\n');
