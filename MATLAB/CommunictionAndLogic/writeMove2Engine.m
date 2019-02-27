%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function EngineMove = writeMove2Engine(move, numOfmovesEnginge)
% move = 'source_square' + 'destintion sqaure'; 
% move = 'old sqaure' + 'new sqaure'
% e.g. move = 'e2e4' - the piece moved from e2 to e4

% The move will be written to the RecMoves.txt file, which will be read by
% the python code that handled the engine communiction + web app page
% update.

% After each time this function is called we need to up the
% numOfmovesEnginge by 1.
userMoves = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\RecMoves.txt','a');
fprintf(userMoves, '%s\n', move);
fclose(userMoves);

% Wait for the engine to finish - blocking the matlab code from continution
num_engineMoves = numOfmovesEnginge;
engineMoves = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\EngineMoves.txt','r');
tline = fgetl(engineMoves);
i = 0;
while ~ischar(tline) || i < num_engineMoves
    if ischar(tline)  
        i = i + 1;
    end
    tline = fgetl(engineMoves);
    pause(0.05)
end
fclose(engineMoves);
EngineMove = tline;
end