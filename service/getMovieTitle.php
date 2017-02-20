<?php

function getMovieTitle($movie_id) {
    $fh = fopen('../movielens/data/u.item','r');
    while (($line = fgets($fh))) {
        $line = explode("|", $line);
        if ($line[0] == $movie_id) {
            return json_encode(['title' => $line[1], 'status' => true]);
        }
    }
    fclose($fh);
    return json_encode(['status' => false]);
}

$movie_id = $_POST['movie_id'];
echo getMovieTitle($movie_id);