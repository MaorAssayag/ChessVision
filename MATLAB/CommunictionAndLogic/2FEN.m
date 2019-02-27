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

FEN = BoardToFEn(board);
FEN

%%
function FEN = BoardToFen(board)
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

FEN = extractAfter(FEN,"/") + " w"; % delete the first /
end