%% Board intialize - starting position - default position
board(1:8,1:8) = "*";
%white
board(1,1) = "r";
board(1,8) = "r";
board(1,2) = "n";
board(1,7) = "n";
board(1,6) = "b";
board(1,3) = "b";
board(1,4) = "q";
board(1,5) = "k";
board(2,:) = "p";
% black
board(8,1) = "R";
board(8,8) = "R";
board(8,2) = "N";
board(8,7) = "N";
board(8,6) = "B";
board(8,3) = "B";
board(8,4) = "Q";
board(8,5) = "K";
board(7,:) = "P";
% Display the board
flipud(board)
FEN = board2fen(board);
FEN

board2 = zeros(8,8);
k = 1;
for i = 1:8
    for j = 1:8
        board2(j,i) = k;
        k = k +1;
    end
end
        
board2
%%
from = 58;
to = 60;
rank = ["a","b","c","d","e","f","g","h"];
column_from = floor(from/8) + 1;
row_from = 9 - (from - (column_from-1)*8);
column_to = floor(to/8) + 1;
row_to = 9 - (to - (column_to-1)*8);
newmove = rank(column_from) + num2str(row_from) + rank(column_to) + num2str(row_to);