function [board] = write2board(board,square_from, square_to)
board(square_to) = board(square_from);
board(square_from) = "*";
end

