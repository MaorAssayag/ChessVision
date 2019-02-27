%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [board] = write2board(board,square_from, square_to)
% This function update the inner board represention with the move that has
% been detected.
% Input :  board -  8x8 matrix of the current state of the board
%          square_from - integer 1-64 represent the 'from' square of the
%                        move
%          square_from - integer 1-64 represent the 'to' square of the
%                        move
% Output : board - updated board
board(square_to) = board(square_from);
board(square_from) = "*";
end

