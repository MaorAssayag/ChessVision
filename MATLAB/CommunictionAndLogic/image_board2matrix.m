%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
clear all
close all
clear('cam');
cam = webcam(2);
cam.Resolution = '1280x800';
cam.Exposure = -8;
cam.Sharpness = 50;
m = load('categoryClassifier7.mat');

%% get the board
find_board=false;
while ~find_board
    pause(0.5);
    current_image = dip_snapshot(cam);
    %current_image = imread('try.jpeg');
    [img_borad,imagePoints_end,imagePoints_start,flag_rotate,find_board]=GetReadyForTheGame(current_image);
end

figure();
subplot(2,1,1);imshow(current_image);title('Input');
subplot(2,1,2);imshow(img_borad);title('End-Of-Process');hold on;
plot(imagePoints_end(:,1),imagePoints_end(:,2),'ro');

%clear_board = GetOnlyBoard(current_image,imagePoints_start,flag_rotate);
%%
m1 = load('categoryClassifier5.mat');
m2 = load('categoryClassifier7.mat');

%%
current_image = imread('board.jpeg');
[img_borad,imagePoints_end,imagePoints_start,flag_rotate,find_board]=GetReadyForTheGame(current_image);
board(1:8,1:8) = "";
board2 = zeros(8,8);

for j = 1:3
    %current_image = dip_snapshot(cam);
    only_old_board = GetOnlyBoard(current_image,imagePoints_start,flag_rotate);
%     for i = 1:64
%         image_train = GetSquareNum(only_old_board, i);
%         temp = classif(image_train, m1);
%         if ((temp{1} == "ee") || (temp{1} == "e"))
%            board(i) = board(i) + ", " + temp{1};
%            board2(i) = 1;
%         end
%     end
    
    for i = 1:64
        if (board2(i) == 0)
            image_train = GetSquareNum(only_old_board, i);
            temp = classif(image_train, m2);
            board(i) = board(i) + ", " + temp{1};
        end
    end
end
board = flip(board)