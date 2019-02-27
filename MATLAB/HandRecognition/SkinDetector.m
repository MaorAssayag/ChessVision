%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function bin = SkinDetector(img_orig)
    se = strel('disk',2);
    img_orig = imerode(img_orig,se);
    
    height = size(img_orig,1);
    width = size(img_orig,2);
    
    %Initialize the output images
    bin = zeros(height,width);
    
    %Apply Grayworld Algorithm for illumination compensation
    img = grayworld(img_orig);    
    
    %Convert the image from RGB to YCbCr
    img_ycbcr = rgb2ycbcr(img);
    Cb = img_ycbcr(:,:,2);
    Cr = img_ycbcr(:,:,3);
    
    %Detect Skin
    [r,c,~] = find(Cb>=77 & Cb<=127 & Cr>=133 & Cr<=173);
    numind = size(r,1);
    
    %Mark Skin Pixels
    for i=1:numind
        bin(r(i),c(i)) = 1;
    end
end