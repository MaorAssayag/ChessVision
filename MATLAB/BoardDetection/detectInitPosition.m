%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [board, pices_old_board, starting_point, turn, ResetFlag] = detectInitPosition(cam, imagePoints_start, flag_rotate, delay)
%% Start arranging the position on the board
% delay = 120 = pause(120/30) = pause(4) secondes
current_image = snapshot(cam);
[starting_point, ResetFlag] = GetNextFrame2(current_image, cam, imagePoints_start, flag_rotate, delay);
if (ResetFlag)
    starting_point = 0;
    pices_old_board = 0;
    board = 0;
    turn = 0;
    return;
end
%figure();imshow(starting_point,[]);
turn=1;
% Board intialize - starting position - default position - refhael
% only_new_board=GetOnlyBoard(snapshot(cam),imagePoints_start,flag_rotate);
% for i = 1:64
%     figure;
%     imshow(GetSquareNum(only_new_board,i));
% end

% for detection
pices_old_board=zeros(8,8);
pices_old_board(1:2,:)=2;
pices_old_board(7:8,:)=1;

% for FEN
board(1:8,1:8) = "*";
%white
board(1,1) = "r";
board(1,8) = "r";
board(1,2) = "n";
board(1,7) = "n";
board(1,6) = "b";
board(1,3) = "b";
board(1,4) = "q";
board(1,5) = "k";
board(2,:) = "p";
% black
board(8,1) = "R";
board(8,8) = "R";
board(8,2) = "N";
board(8,7) = "N";
board(8,6) = "B";
board(8,3) = "B";
board(8,4) = "Q";
board(8,5) = "K";
board(7,:) = "P";
end

