%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [img_borad,imagePoints_end,imagePoints_start,flag_rotate,find_board, clear_board] = detectChessBoard(cam, delay)
%% Detect the checker board and the squre positions
% delay = 0.5
find_board=false;
while ~find_board
    pause(delay);
    clear_board = snapshot(cam);
    [img_borad,imagePoints_end,imagePoints_start,flag_rotate,find_board]=GetReadyForTheGame(clear_board);
end
figure;
% subplot(2,1,1);imshow(clear_board);title('Input');
% subplot(2,1,2);title('End-Of-Process');hold on;
% plot(imagePoints_end(:,1),imagePoints_end(:,2),'ro');
imshow(img_borad);
hold on;
plot(imagePoints_end(:,1),imagePoints_end(:,2),'bo');
end