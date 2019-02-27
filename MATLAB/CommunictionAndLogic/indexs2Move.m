%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function newMove = indexs2Move(from, to)
% This function will return the currect way to represent moves for the
% engine communiction (via the python code).
% input - 2 int numbers, represent the from & to squares as numbers from
% 1-64.
% output - UCI move, e.g. e2e4

% e.g. the detected move was from the 20 square to the 22 square
% rank 'a' in the chess board conatin square 1 to 8, rank b 9 to 16 etc. 
% the black side is the top one, and we start counting from there.
%      1     9    17    25    33    41    49    57
%      2    10    18    26    34    42    50    58
%      3    11    19    27    35    43    51    59
%      4    12    20    28    36    44    52    60
%      5    13    21    29    37    45    53    61
%      6    14    22    30    38    46    54    62
%      7    15    23    31    39    47    55    63
%      8    16    24    32    40    48    56    64
rank = ["a","b","c","d","e","f","g","h"];

column_from = ceil(from/8);
row_from = 9 - mod(from,8);
if (row_from == 9)
    row_from = 1;
end

column_to = ceil(to/8);
row_to = 9 - mod(to,8);
if (row_to == 9)
    row_to = 1;
end

newMove = rank(column_from) + num2str(row_from) + rank(column_to) + num2str(row_to);
end

