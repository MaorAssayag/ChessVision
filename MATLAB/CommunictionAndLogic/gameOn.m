%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function gameOn(old_board ,cam ,imagePoints_start,flag_rotate,delay, only_old_board, pices_old_board, imagePoints_end, img_borad, turn, board, m1, m2)
% The main function of detecting the moves of the user, legallity feedback
% etc'. This function finsihed when the game is finished (the user pressed
% 'RESET' in the microframework UI).
% delay = 60
temp_board = zeros(8,8);
illegel_once = 0;
[y,Fs] = audioread('illegal.ogg');
[y2,Fs2] = audioread('correct.ogg');
engineMoves = 1;
cant_escape = 0;
back_to_llegal = 1; % initial position is legall
temp_pices_old_board = zeros(8,8);
while 1  
    if checkReset()
        disp('reset detected')
        break;
    end
    [new_board, ResetFlag] = GetNextFrame2(old_board ,cam ,imagePoints_start,flag_rotate,delay);
    only_new_board = GetOnlyBoard(new_board,imagePoints_start,flag_rotate);
    
    % Find the move
    [pices_new_board,move_from,move_to,flag_castle,flag_real_change]=GetNewPositions2(only_old_board,only_new_board,pices_old_board,imagePoints_end,turn, img_borad, board, m1, m2);
    
    if checkReset() || ResetFlag
        disp('reset detected')
        break;
    end
    
    if flag_real_change
        if back_to_llegal
            currentMoceUCI = indexs2Move(move_from, move_to);
            currentMoceUCI
            EngineMove = writeMove2Engine(currentMoceUCI, engineMoves)
            engineMoves = engineMoves + 1;
        end
        
       if (EngineMove == "None") 
              while ~checkReset()
                  pause(0.05)
              end
              disp('reset detected')
              break;
       end
       
       if EngineMove ~= "illegal"
            turn = turn + 1;
            temp_pices_old_board = zeros(8,8);
       else
            back_to_llegal = isequal(pices_new_board,temp_pices_old_board);
            if ~back_to_llegal && ~isequal(temp_pices_old_board, zeros(8,8))
                sound(y,Fs); % Make a sound of ilegal move
                pause(1.5);
            else
                if (~illegel_once)
                    illegel_once = 1;
                    temp_pices_old_board = pices_old_board;
                    temp_board = board;
                end
            end
            if back_to_llegal
                sound(y2,Fs2); % % Make a sound of back to legall position
                illegel_once = 0;
                pause(1.5);
            end
       end 
        pices_old_board = pices_new_board;
        board = write2board(board,move_from, move_to);
        board
    end
    old_board = snapshot(cam);
    only_old_board = GetOnlyBoard(old_board,imagePoints_start,flag_rotate);
    if (cant_escape)
        pices_old_board = temp_pices_old_board;
        board = temp_board;
        back_to_llegal = 1;
    end
end
end