%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
% This function helps to create a dataset
clear all
cam = webcam(2);
cam.Resolution = '1280x800';
cam.Exposure = -7;
cam.Sharpness = 50;
global m;
m = load('categoryClassifier6.mat');

%% get the board
find_board=false;
while ~find_board
    pause(0.5);
    current_image = snapshot(cam);
    [img_borad,imagePoints_end,imagePoints_start,flag_rotate,find_board]=GetReadyForTheGame(current_image);
end

figure();
subplot(2,1,1);imshow(current_image);title('Input');
subplot(2,1,2);imshow(img_borad);title('End-Of-Process');hold on;
plot(imagePoints_end(:,1),imagePoints_end(:,2),'ro');
%currentImageNum = 1;
%%
current_image = snapshot(cam);
only_old_board = GetOnlyBoard(current_image,imagePoints_start,flag_rotate);
for i = 1:64
    image_train = GetSquareNum(only_old_board, i);
    if (i == 64 || i == 8)
        imwrite(image_train,sprintf('ObjectYaniv/r/im_%d.jpg', currentImageNum),'jpg');
    end
    if (i == 57 || i == 1)
        imwrite(image_train,sprintf('ObjectYaniv/rr/im_%d.jpg', currentImageNum),'jpg');
    end
    if (i == 56 || i == 16)
        imwrite(image_train,sprintf('ObjectYaniv/n/im_%d.jpg', currentImageNum),'jpg');
    end
    if (i == 49 || i == 9)
        imwrite(image_train,sprintf('ObjectYaniv/nn/im_%d.jpg', currentImageNum),'jpg');
    end
    if (i == 48 || i == 24)
        imwrite(image_train,sprintf('ObjectYaniv/b/im_%d.jpg', currentImageNum),'jpg');
    end
    if (i == 41 || i == 17)
        imwrite(image_train,sprintf('ObjectYaniv/bb/im_%d.jpg', currentImageNum),'jpg');
    end
    if (i == 32)
        imwrite(image_train,sprintf('ObjectYaniv/k/im_%d.jpg', currentImageNum),'jpg');
    end
    if (i == 25)
        imwrite(image_train,sprintf('ObjectYaniv/kk/im_%d.jpg', currentImageNum),'jpg');
    end
    if (i == 40)
        imwrite(image_train,sprintf('ObjectYaniv/q/im_%d.jpg', currentImageNum),'jpg');
    end
    if (i == 33)
        imwrite(image_train,sprintf('ObjectYaniv/qq/im_%d.jpg', currentImageNum),'jpg');
    end
    if (mod(i,8)==7)
        imwrite(image_train,sprintf('ObjectYaniv/p/im_%d.jpg', currentImageNum),'jpg');
    end
    if (mod(i,8)==2)
        imwrite(image_train,sprintf('ObjectYaniv/pp/im_%d.jpg', currentImageNum),'jpg');
    end
    
    currentImageNum = currentImageNum + 1;
end
