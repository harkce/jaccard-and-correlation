$(document).ready(function(){
     $("#movie_1").on("input", function(e){
        var txt1 = $("#movie_1").val();
        if (txt1 == "") {
            $("#txt_movie1").text("");
        } else {
            $.ajax({
                type: "POST",
                url: "/service/getMovieTitle.php",
                data: {movie_id: txt1},
                success: function(data) {
                    var response = JSON.parse(data);
                    if (response.status) {
                        $("#txt_movie1").text(response.title);
                    } else {
                        $("#txt_movie1").text("Movie not found!");
                    }
                }
            });
        }
    });

    $("#movie_2").on("input", function(e){
        var txt1 = $("#movie_2").val();
        if (txt1 == "") {
            $("#txt_movie2").text("");
        } else {
            $.ajax({
                type: "POST",
                url: "/service/getMovieTitle.php",
                data: {movie_id: txt1},
                success: function(data) {
                    var response = JSON.parse(data);
                    if (response.status) {
                        $("#txt_movie2").text(response.title);
                    } else {
                        $("#txt_movie2").text("Movie not found!");
                    }
                }
            });
        }
    });

    $("#movie").on("input", function(e){
        var txt1 = $("#movie").val();
        if (txt1 == "") {
            $("#txt_movie").text("");
        } else {
            $.ajax({
                type: "POST",
                url: "/service/getMovieTitle.php",
                data: {movie_id: txt1},
                success: function(data) {
                    var response = JSON.parse(data);
                    if (response.status) {
                        $("#txt_movie").text(response.title);
                    } else {
                        $("#txt_movie").text("Movie not found!");
                    }
                }
            });
        }
    });

    $("#calculate").click(function(){
        var txt1 = $("#movie_1").val();
        var txt2 = $("#movie_2").val();
        if (txt1 == "" || txt2 == "") {
            $("#jaccard_score").text("Please fill out both movie id");
            $("#correlation_score").text("");
        } else {
            $("#calculate").prop("disabled", true);
            $("#calculate").text("Calculating...");
            $("#jaccard_score").text("Jaccard Score: Calculating...");
            $("#correlation_score").text("Correlation Score: Calculating...");
            $.ajax({
                type: "POST",
                url: "/service/jaccard_2.php",
                data: {movie_1: txt1, movie_2: txt2},
                success: function(data) {
                    var response = JSON.parse(data);
                    var jaccard_score = response.jaccard_score;
                    var time = response.time;
                    $("#jaccard_score").text("Jaccard Score: " + jaccard_score + " (" + time + ")");
                }
            }),
            $.ajax({
                type: "POST",
                url: "/service/correlation_2.php",
                data: {movie_1: txt1, movie_2: txt2},
                success: function(data) {
                    var response = JSON.parse(data);
                    var correlation_score = response.correlation_score;
                    var time = response.time;
                    $("#correlation_score").text("Correlation Score: " + correlation_score + " (" + time + ")");
                }
            });
        }
    });

    $("#search").click(function(){
        var txt_movie = $("#movie").val();
        if (txt_movie == "") {
            $("#validate").text("Please fill out movie id");
            $("#jaccard_result").text("");
            $("#correlation_result").text("");
        } else {
            $("#validate").text("");
            $("#search").prop("disabled", true);
            $("#search").text("Searching...");
            $("#jaccard_result").text("");
            $("#correlation_result").text("");
            $.ajax({
                type: "POST",
                url: "/service/jaccard_5.php",
                data: {movie_id: txt_movie},
                success: function(data) {
                    var response = JSON.parse(data);
                    var hasil = "Jaccard ";
                    hasil = hasil + " (" + response.time + ") :<ol>";
                    for (i = 0; i < response.movies.length; i++) {
                        hasil = hasil + "<li>" + response.movies[i].movie + " (" + response.movies[i].jaccard + ")</li>";
                    }
                    hasil = hasil + "</ol>";
                    $("#jaccard_result").html(hasil);
                }
            });
            $.ajax({
                type: "POST",
                url: "/service/correlation_5.php",
                data: {movie_id: txt_movie},
                success: function(data) {
                    var response = JSON.parse(data);
                    var hasil = "Correlation ";
                    hasil = hasil + " (" + response.time + ") :<ol>";
                    for (i = 0; i < response.movies.length; i++) {
                        hasil = hasil + "<li>" + response.movies[i].movie + " (" + response.movies[i].correlation + ")</li>";
                    }
                    hasil = hasil + "</ol>";
                    $("#correlation_result").html(hasil);
                }
            });
        }
    });
});

$(document).ajaxStop(function(){
    $("#calculate").prop("disabled", false);
    $("#calculate").text("Calculate");
    $("#search").prop("disabled", false);
    $("#search").text("Search");
});