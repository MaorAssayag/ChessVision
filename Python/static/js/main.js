$(document).ready(function(){
    //connect to the socket server.
    var socket = io.connect('http://' + document.domain + ':' + location.port + '/test');

    //receive board state from server
    socket.on('newmove', function(msg) {
        console.log("Received board" + msg.board);
        $('#board').html(msg.board);
    });

    //receive Engine Level
    socket.on('enginelevel', function(msg) {
        console.log("Received Engine Level" + msg.level);
        $('#engine_level').html("Engine Level : " + msg.level);
    });

    //receive illegal move/position alret from server
    socket.on('illegalmove', function(msg) {
    console.log("Received illegal move" + msg.color);
     $('#illegal_text').css('color', msg.color);
     // if its illegal move/position than color = red, play the sound of illegal move/position
     if (msg.color == "#e50000"){
         $('#illegal_sound')[0].play();}
    });

    //receive game result from server
    socket.on('endgameresult', function(msg) {
     console.log("Received end game result" + msg.result);
     if (msg.result == "1/2-1/2"){
         $('#draw_text').css('color', msg.color);
         $('#draw_sound')[0].play();
     }
     else if (msg.result == "1-0"){
         $('#whitewon_text').css('color', msg.color);
         $('#win_sound')[0].play();

     } else if (msg.result == "0-1"){
         $('#blackwon_text').css('color', msg.color);
         $('#win_sound')[0].play();
     }
    });


    socket.on('newgame_sound', function() {
        console.log("New game sound");
         $('#newgame_sound')[0].play();
    });

    socket.on('newmove_sound', function() {
        console.log("New move sound");
        $('#move_sound')[0].play();
    });

});