function [ResetFlag] = checkReset()
% Wait for the engine to finish - blocking the matlab code from continution
resetFile = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\Reset.txt','r');
tline = fgetl(resetFile);
if (tline ~= -1)
    % The game is in reset mode - reset the file itselef
    fclose(resetFile);
    resetFile = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\Reset.txt','w');
    tline
    ResetFlag = 1;
else
    ResetFlag = 0;
end
fclose(resetFile);
end

