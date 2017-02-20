<?php

ini_set('max_execution_time', 300); //300 seconds = 5 minutes

function getMovieTitle($movie_id) {
    $fh = fopen('../movielens/data/u.item','r');
    while (($line = fgets($fh))) {
        $line = explode("|", $line);
        if ($line[0] == $movie_id) {
            return $line[1];
        }
    }
    fclose($fh);
    return "Movie not found!";
}

$rustart = getrusage();

$movie_1 = $_POST["movie_id"];
$r1_count;

$jaccard = [];

$uitem = fopen('../movielens/data/u.item','r');
$i = 0;
$j = 0;
while (($uitem_line = fgets($uitem))) {
    $uitem_line = explode("|", $uitem_line);
    $movie_2 = $uitem_line[0];

    $rated_1 = [];
    $rated_2 = [];
    $rated_both = 0;
    $fh = fopen('../movielens/data/u.data','r');
    $i = 0;
    while (($line = fgets($fh))) {
        $line = explode("\t", $line);
        if ($line[1] == $movie_1) {
            array_push($rated_1, $line[0]);
            if (in_array($line[0], $rated_2)) {
                $rated_both++;
            }
            $i++;
        } else if ($line[1] == $movie_2) {
            array_push($rated_2, $line[0]);
            if (in_array($line[0], $rated_1)) {
                $rated_both++;
            }
        }
    }
    fclose($fh);
    $hasil = $rated_both / ((count($rated_1) + count($rated_2)) - $rated_both);
    $res = ['movie' => getMovieTitle($movie_2), 'jaccard' => $hasil];
    array_push($jaccard, $res);
    if (count($jaccard) > 5) {
        $sort = [];
        foreach($jaccard as $k => $v) {
            $sort['jaccard'][$k] = $v['jaccard'];
        }
        array_multisort($sort['jaccard'], SORT_DESC, $jaccard);
        array_pop($jaccard);
    }
    $j++;
    // print($j . "\n");
    // echo count($rated_1) . "ahay\n";
}
fclose($uitem);

// echo "\n";

function rutime($ru, $rus, $index) {
    return ($ru["ru_$index.tv_sec"]*1000 + intval($ru["ru_$index.tv_usec"]/1000))
     -  ($rus["ru_$index.tv_sec"]*1000 + intval($rus["ru_$index.tv_usec"]/1000));
}

$ru = getrusage();
// echo "This process used " . rutime($ru, $rustart, "utime") .
//     " ms for its computations\n";
// echo "It spent " . rutime($ru, $rustart, "stime") .
//     " ms in system calls\n";

echo json_encode(['movies' => $jaccard, 'time' => rutime($ru, $rustart, "utime") . " ms"]);