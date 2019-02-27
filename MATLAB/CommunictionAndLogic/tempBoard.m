%clear all
clear('cam');
cam = webcam(2);
cam.Resolution = '1280x800';
cam.Exposure = -9;
%preview(cam)

%%
ResetFlag = checkReset();

while ResetFlag
    %% Detect the checker board and the squre positions
    delay = 0.5; % pause of 0.5 sec for callibration
    [img_borad,imagePoints_end,imagePoints_start,flag_rotate,find_board, clear_board] = detectChessBoard(cam, delay);

    %% Start arranging the position on the board
    llegal_position = false;
    while (~llegal_position)
        delay = 120;
        [board, pices_old_board, starting_point, turn] = detectInitPosition(cam, imagePoints_start, flag_rotate, delay);
        FEN = board2fen(board);
        llegal_position = writeFen2Engine(FEN);
        if (llegal_position == 0)
            disp('illegal_position');
        end
    end
    % Now the position is llegal

    %% Save the current state of the board
    old_board = starting_point;
    only_old_board = GetOnlyBoard(old_board,imagePoints_start,flag_rotate);

    %%
    delay = 60;
    gameOn(old_board ,cam ,imagePoints_start,flag_rotate,delay, only_old_board, pices_old_board, imagePoints_end, img_borad, turn);
end