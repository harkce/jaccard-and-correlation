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

$movie_1 = $_POST['movie_id'];

function in_array_r($needle, $haystack) {
    $i = 0;
    foreach($haystack as $item) {
        if ($needle == $item[0]) {
            return $i;
        }
        $i++;
    }
    return -1;
}

$correlation = [];

$uitem = fopen('../movielens/data/u.item','r');
$j = 0;
while (($uitem_line = fgets($uitem))) {
    $uitem_line = explode("|", $uitem_line);
    $movie_2 = $uitem_line[0];

    $rated_1 = [];
    $rated_2 = [];
    $rated_both = 0;

    $sigma_x = 0;
    $sigma_y = 0;
    $sigma_x2 = 0;
    $sigma_y2 = 0;
    $sigma_xy = 0;

    $fh = fopen('../movielens/data/u.data','r');
    while (($line = fgets($fh))) {
        $line = explode("\t", $line);
        if ($line[1] == $movie_1) {
            array_push($rated_1, [$line[0], 'rate' => $line[2]]);
            $cari = in_array_r($line[0], $rated_2);
            if ($cari != -1) {
                $rated_both++;
                $sigma_x += $line[2];
                $sigma_y += $rated_2[$cari]['rate'];
                $sigma_x2 += pow($line[2],2);
                $sigma_y2 += pow($rated_2[$cari]['rate'], 2);
                $sigma_xy += $line[2] * $rated_2[$cari]['rate'];
            }
        } else if ($line[1] == $movie_2) {
            array_push($rated_2, [$line[0], 'rate' => $line[2]]);
            $cari = in_array_r($line[0], $rated_1);
            if ($cari != -1) {
                $rated_both++;
                $sigma_x += $rated_1[$cari]['rate'];
                $sigma_y += $line[2];
                $sigma_x2 += pow($rated_1[$cari]['rate'],2);
                $sigma_y2 += pow($line[2], 2);
                $sigma_xy += $line[2] * $rated_1[$cari]['rate'];
            }
        }
    }
    fclose($fh);

    $n = $rated_both;
    $pembilang = $n * $sigma_xy - $sigma_x * $sigma_y;
    $penyebut = sqrt($n * $sigma_x2 - pow($sigma_x, 2)) * sqrt($n * $sigma_y2 - pow($sigma_y, 2));
    $hasil;

    if ($penyebut == 0) {
        $hasil = 0;
    } else {
        $hasil = $pembilang / $penyebut;
    }
    $res = ['movie' => getMovieTitle($movie_2), 'correlation' => $hasil];
    array_push($correlation, $res);
    if (count($correlation) > 5) {
        $sort = [];
        foreach($correlation as $k => $v) {
            $sort['correlation'][$k] = $v['correlation'];
        }
        array_multisort($sort['correlation'], SORT_DESC, $correlation);
        array_pop($correlation);
    }
    $j++;
    // echo $j . "\n";
    // echo count($rated_1) . "ahay\n";
}
fclose($uitem);

// print_r($correlation);

echo "\n";

function rutime($ru, $rus, $index) {
    return ($ru["ru_$index.tv_sec"]*1000 + intval($ru["ru_$index.tv_usec"]/1000))
     -  ($rus["ru_$index.tv_sec"]*1000 + intval($rus["ru_$index.tv_usec"]/1000));
}

$ru = getrusage();
// echo "This process used " . rutime($ru, $rustart, "utime") .
//     " ms for its computations\n";
// echo "It spent " . rutime($ru, $rustart, "stime") .
//     " ms in system calls\n";

echo json_encode(['movies' => $correlation, 'time' => rutime($ru, $rustart, "utime") . " ms"]);