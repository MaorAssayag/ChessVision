%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [ new_img,is_rotated ] = rotate_if_necessary( img,mean_mat_64 )
%the function get:
%img - [N*M*3] or [N*m]
%mean_mat_64 - [8*8] - mean of any square

%the function return:
%new_img - [N*M*3] or [N*m]
%is_rotated = [bool] -rotate if the right low square isnt white



is_rotated=false;
lh2rl=mean_mat_64(8,8)+mean_mat_64(1,1);
rl2ll=mean_mat_64(8,1)+mean_mat_64(1,8);
if lh2rl<rl2ll
   new_img=imrotate(img,90);
   is_rotated=true;
else
   new_img=img;
end

end

