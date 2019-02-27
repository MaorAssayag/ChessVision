%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
% MAIN CODE
%% Setup
clear all
close all
clc
cam = webcam(2);
cam.Resolution = '1280x800';
cam.Exposure = -7;
cam.Sharpness = 50;
preview(cam);
[y2,Fs2] = audioread('board_detected.ogg');
try
m2 = load("categoryClassifier7.mat");
catch ME
end
try
m1 = load("categoryClassifier5.mat");
catch ME
end

%% While user the didnt connect in the UI (or pressed 'Reset')
disp('waiting for Reset')
Reset = false;
while ~Reset
   resetFile = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\Reset.txt','r');
   tline = fgetl(resetFile);
   if (tline ~= -1)
       % The game is in reset mode - reset the file itselef
       fclose(resetFile);
       resetFile = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\Reset.txt','w');
       Reset = true;
   end
    fclose(resetFile); 
end

while 1

%% Recognize hand gesture
close all;
[time, skill_level] = HandRecognition(cam);
if (skill_level > 5)
    skill_level = 3;
end
skill_level

%% Write skill_level to the EngineLevel.txt file
skillFile = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\EngineLevel.txt','w');
fprintf(skillFile, '%d\n', skill_level*5);
fclose(skillFile);

%% Detecet the initial position 
% while EngineMoves isnt 'None' - the game isnt over

    %% Detect the checker board and the squre positions
    delay = 0.5; % pause of 0.5 sec for callibration
    [img_borad,imagePoints_end,imagePoints_start,flag_rotate,find_board, clear_board] = detectChessBoard(cam, delay);
    sound(y2,Fs2); % Make a sound of detected board
    
    %% Start arranging the position on the board
    llegal_position = false;
    while (~llegal_position)
        delay = 120;
        [board, pices_old_board, starting_point, turn, ResetFlag] = detectInitPosition(cam, imagePoints_start, flag_rotate, delay);
        if (ResetFlag)
            break;
        end
        
        FEN = board2fen(board);
        llegal_position = writeFen2Engine(FEN);
        if (llegal_position == 0)
            disp('illegal_position');
        end
    end
    % Now the position is llegal
    if (ResetFlag)
        continue;
    end
    close all;
    %% Save the current state of the board
    old_board = starting_point;
    only_old_board = GetOnlyBoard(old_board,imagePoints_start,flag_rotate);

    %% Detecet new moves and determine the new position
    delay = 30;
    gameOn(old_board ,cam ,imagePoints_start,flag_rotate,delay, only_old_board, pices_old_board, imagePoints_end, img_borad, turn, board, m1, m2);
end