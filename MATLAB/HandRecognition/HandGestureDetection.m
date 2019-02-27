%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [time,N_rag_med, FlagBlankImage] = HandGestureDetection(img, debug)
tic
Ibw = SkinDetector(img);

% Rotate the image so that the center of the image will be in the right
% side
[a b c] = size(Ibw);
% if sum(sum(Ibw(:,1:b/2))) > sum(sum(Ibw(:,b/2:end)))
%     %Ibw = imrotate(Ibw,180);
%     Ibw = transpose(Ibw);
%     [a b c] = size(Ibw);
% end
Ibw = transpose(Ibw);

if debug 
    figure();
    imshow(Ibw);
    title('after skin detector');
end

idx = (Ibw==1);
out = sum(idx(:));
weight = out/(a*b);
% was /20
radi = round(weight*sqrt(a^2 + b^2)/40);
se = strel('disk',radi);
Ibw = bwareaopen(Ibw,15000);
if debug 
    figure();
    imshow(Ibw);
    title('after bwareaopen 15000');
end

Ibw = imdilate(Ibw,se);
if debug
    figure();
    imshow(Ibw);
    title('after imclose');
    hold on;
end

Ibw = imfill(Ibw,'holes');

if debug
    figure();
    imshow(Ibw);
    title('after fill');
    hold on;
end

% Define centroid
[Ibw N1] = bwlabel(Ibw);
Ibw = Ibw.*(Ibw==1);
stat = regionprops(Ibw ,'centroid');
stat2 = regionprops(Ibw ,'Orientation');
if (~isempty(stat2))
   ang = (stat2(1).Orientation*pi/180);

    if debug
        for x = 1: numel(stat)
             plot(stat(x).Centroid(1),stat(x).Centroid(2),'ro');
        end
    end
    sizes_circ = 1.1:0.05:3;
    n_new=zeros(size(sizes_circ));

    i= 1;
    n=1;
    [imageSizeY imageSizeX] = size(Ibw);
    [columnsInImage rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
    radius = round(sqrt(weight)*sqrt(a^2 + b^2)/2);
    aa = round(radius*cos(ang+pi/2));
    bb = round(radius*sin(ang+pi/2));

    while i <= length(sizes_circ) && n >=1
        % Clear the mask with an increasing radius from the center of mass of
        % the hand
        mask = (rowsInImage - stat(1).Centroid(2)).^2+ (columnsInImage - stat(1).Centroid(1)).^2 <= (sizes_circ(i).*radius./1.5).^2;
        fingers_img = Ibw.*(1-mask);
        mask2 = (rowsInImage - stat(1).Centroid(2)-aa).^2+ (columnsInImage - stat(1).Centroid(1)-bb).^2 <= (sizes_circ(i).*radius).^2;
        fingers_img = fingers_img.*(1- mask2);
       % fingers_img = imclose(fingers_img,se);

        if debug
            figure();
            imshow(fingers_img);
        end

        % Count the number of fingers
        [img1 n] = bwlabel(fingers_img);
        n_new(i) = n;
        i=i+1;
    end

%     if length(find(n_new==max(n_new)))==1
%         n_new(find(n_new==max(n_new)))=[];
%     end
% 
%     N = max(n_new);
      n_new_non_zero=n_new(n_new~=0);
      N = ceil(median(n_new_non_zero));
      s_tag=length(n_new_non_zero); 
      N_tag=n_new_non_zero(fix(s_tag)/5:ceil(3*s_tag/4));
      N_rag_med=ceil(median(N_tag));
      
    time = toc;
    FlagBlankImage = 0;
else
    FlagBlankImage = 1;
    N_rag_med = 0;
    time = 0;
    close all
end
end
