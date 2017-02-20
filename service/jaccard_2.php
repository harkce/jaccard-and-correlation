<?php

$rustart = getrusage();

$movie_1 = $_POST['movie_1'];
$movie_2 = $_POST['movie_2'];

$rated_1 = [];
$rated_2 = [];
$rated_both = 0;

$fh = fopen('../movielens/data/u.data','r');
while (($line = fgets($fh))) {
    $line = explode("\t", $line);
    if ($line[1] == $movie_1) {
        array_push($rated_1, $line[0]);
        if (in_array($line[0], $rated_2)) {
            $rated_both++;
        }
    } else if ($line[1] == $movie_2) {
        array_push($rated_2, $line[0]);
        if (in_array($line[0], $rated_1)) {
            $rated_both++;
        }
    }
}
fclose($fh);

$hasil = $rated_both / ((count($rated_1) + count($rated_2)) - $rated_both);

// echo $hasil . "\n";

function rutime($ru, $rus, $index) {
    return ($ru["ru_$index.tv_sec"]*1000 + intval($ru["ru_$index.tv_usec"]/1000))
     -  ($rus["ru_$index.tv_sec"]*1000 + intval($rus["ru_$index.tv_usec"]/1000));
}

$ru = getrusage();
// echo "This process used " . rutime($ru, $rustart, "utime") .
//     " ms for its computations\n";
// echo "It spent " . rutime($ru, $rustart, "stime") .
//     " ms in system calls\n";

$result = ['jaccard_score' => $hasil, 'time' => rutime($ru, $rustart, "utime") . " ms"];
echo json_encode($result);