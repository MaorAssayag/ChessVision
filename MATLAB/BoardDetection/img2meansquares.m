%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [ mat_64 ] = img2meansquares( img,imagePoints )
%the function get
%img - [N*M*3] or [N*M]
%imagePoints - [49*2]

%the function return
% mat_64 - [8*8] with the mean of any square


img=img2gray(img);

mat_64=zeros(8,8);
mean_squre_size=fix(mean( ( min(imagePoints(:,:))+(max(imagePoints(:,:))/7) )/2 ));
shlish_size=10;%fix ( mean_squre_size/4 );


for i=1:8
    for j=1:8
         mat_64(i,j)=mean2( img( shlish_size+(i-1)*mean_squre_size:i*mean_squre_size-shlish_size , shlish_size+(j-1)*mean_squre_size:j*mean_squre_size-shlish_size )); 
    end
end


end

