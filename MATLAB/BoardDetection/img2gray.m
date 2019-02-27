%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [ gray_img ] = img2gray( img )
%the function get:
%img - [N*M*3] or [N*M]

%the function convert to gray if the img in rgb
if size(img,3)==3
    gray_img=rgb2gray(img);
else
    gray_img=img;
end 

end

