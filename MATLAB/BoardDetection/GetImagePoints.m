%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [ imagePoints,boardSize,flag] = GetImagePoints( img )
% GetImagePoints

%the function get an image
%   img = N*M*3 (RGB) or N*M (gray_scale)

%the function return:
%imagePoints of the chess_board [N*2]
%and the size of the board [1*2]

th=0.15;
flag=true;

while flag && th<0.8
[imagePoints,boardSize,] = detectCheckerboardInOneImageMy(img,th);
if boardSize(1)==8 && boardSize(2)==8
    flag=false; 
else 
    th=th+0.05;
end

end

end