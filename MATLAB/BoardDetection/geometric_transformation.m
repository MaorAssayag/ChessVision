%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [ new_img ] = geometric_transformation( img,imagePoints)
%the function get:
%img - [N*M*3] or [N*M]
%imagePoints - [49*2]

%the function return:
%new_img - [Q*Q*3] (Q=min{N,M})

[y_size,x_size,~]=size(img);
new_img_size=min(y_size,x_size);

pts=[imagePoints(1,:);imagePoints(43,:);imagePoints(7,:);imagePoints(49,:)];
fixedPoints = [new_img_size/8 new_img_size/8; 7*new_img_size/8 new_img_size/8;new_img_size/8  7*new_img_size/8;7/8*new_img_size 7*new_img_size/8];
tform = fitgeotrans(pts,fixedPoints,'projective');
new_img = imwarp(img,tform,'OutputView',imref2d([new_img_size new_img_size 3]));

end

