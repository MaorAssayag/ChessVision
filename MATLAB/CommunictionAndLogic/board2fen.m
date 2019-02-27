%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [FEN] = board2fen(board)
% This function gets an 8x8 string matrix represent the current board, and
% return a FEN string.
% We can use this function to start a game from any board position
% detected. An assumption is that the position is white to move.

% board - 8x8 matrix, "*" represent empty sqaure, 'K' - white king, 'k' -
% black pawn etc'.

% Board intialize example - starting position - default position
% board(1:8,1:8) = "*";
% White
% board(1,1) = "r";
% board(1,8) = "r";
% board(1,2) = "n";
% board(1,7) = "n";
% board(1,6) = "b";
% board(1,3) = "b";
% board(1,4) = "q";
% board(1,5) = "k";
% board(2,:) = "p";
% Black
% board(8,1) = "R";
% board(8,8) = "R";
% board(8,2) = "N";
% board(8,7) = "N";
% board(8,6) = "B";
% board(8,3) = "B";
% board(8,4) = "Q";
% board(8,5) = "K";
% board(7,:) = "P";
%
FEN = "";
freeSquares = 0;
rankFEN = "";
for i = 1:8
    for j = 1:8
        if (board(i,j)=="*")
            freeSquares = freeSquares + 1;
        elseif (freeSquares ~= 0)
            rankFEN = rankFEN + int2str(freeSquares) + board(i,j);
            freeSquares = 0;
        else
            rankFEN = rankFEN + board(i,j);
        end
    end
    if (freeSquares ~= 0)
        rankFEN = rankFEN + int2str(freeSquares);
    end
    FEN = FEN + "/" + rankFEN;
    rankFEN = "";
    freeSquares = 0;
end
% delete the first '/' and add the missing FEN format parts
if (extractAfter(FEN, "/") == "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR")
    FEN = extractAfter(FEN,"/") + " w KQkq - 0 1"; 
    disp('Default position');
else
    FEN = extractAfter(FEN,"/") + " w - - 0 1"; 
    disp('Not default position');
end
end