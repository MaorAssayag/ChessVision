board(1:8,1:8) = "*";
% White
board(1,1) = "rr";
board(1,8) = "rr";
board(1,2) = "nn";
board(1,7) = "nn";
board(1,6) = "bb";
board(1,3) = "bb";
board(1,4) = "qq";
board(1,5) = "kk";
board(2,:) = "pp";
% Black
board(8,1) = "r";
board(8,8) = "r";
board(8,2) = "n";
board(8,7) = "n";
board(8,6) = "b";
board(8,3) = "b";
board(8,4) = "q";
board(8,5) = "k";
board(7,:) = "p";
board

board(1:8,1:8) = "*";
board(1:2, 1:8) = 2;
board(7:8,1:8) = 1;
board