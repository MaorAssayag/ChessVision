%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [ only_board ] = GetOnlyBoard( full_img,imagePoints_start,flag_rotate )
%the function get:
%full_img - [N*M*3] or [N*M]
%imagePoints_start - points of the board in the start iamge
%flag_rotate - if the board need to rotate

%the function return only the board after pre-process

only_board=geometric_transformation(full_img,imagePoints_start);
if flag_rotate
       only_board=imrotate(only_board,90);
end


end

