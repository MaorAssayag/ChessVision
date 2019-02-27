%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [ square_img ] = GetSquareNum( img_board,num )
%the funtion get:
%img_board - img of the board only
%num - num of square to extract

%the function return 
%square_img - only the square u ask to extrat

size_mat=size(img_board);
mean_squre_size=fix(size_mat/8);
num_row=mod(num,8);
num_col=ceil(num/8);

if(num_row==0)
    num_row=8;
end

square_img=img_board(1+(num_row-1)*mean_squre_size:num_row*mean_squre_size,1+(num_col-1)*mean_squre_size:num_col*mean_squre_size);

end

