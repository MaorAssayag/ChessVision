%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [ category_type ] = adjust_types(board_type)
% This function simply adjust between labling of the pieces
% (classification) and the formal FEN represention.
switch board_type
    case "R"
        category_type = "r";
    case "N"
        category_type = "n";
    case "Q"
        category_type = "q";
    case "K"
        category_type = "k";
    case "B"
        category_type = "b";
    case "P"
        category_type = "p";
    case "r"
        category_type = "rr";
    case "n"
        category_type = "nn";
    case "q"
        category_type = "qq";
    case "k"
        category_type = "kk";
    case "b"
        category_type = "bb";
    case "p"
        category_type = "pp";
end
end

