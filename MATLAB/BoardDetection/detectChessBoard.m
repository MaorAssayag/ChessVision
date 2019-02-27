%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [img_borad,imagePoints_end,imagePoints_start,flag_rotate,find_board, clear_board] = detectChessBoard(cam, delay)
% This function is aid function for the main code. The output is the the 
% final board image after transformations & the points of intersections (with some stats).
% Inputs : cam - the camera object
%          delay - how much each loop should wait before trying again
% Outputs :img_board - extraction of the chess board in the frame
%          imagePoints_end  - the corrners of the squares in the
%                            chessboard
%          imagePoints_start - inital corners before transformations
%          flag_rotate - does the board rotated in the gemotric
%                        transformations
%          find_board - was the extraction successful ? is there a chessboard in the frame ?
%          clear_board - unused, debug only
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