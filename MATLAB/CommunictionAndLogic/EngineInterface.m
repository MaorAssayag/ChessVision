%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
% Temp file, an example of how the text-based communiction works
string1 = 'e2e4';
userMoves = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\RecMoves.txt','a');
fprintf(userMoves, '%s\n', string1);

num_engineMoves = 0;
while(true)
engineMoves = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\EngineMoves.txt','r');
tline = fgetl(engineMoves);
i = 0;
while ischar(tline)
    i = i + 1;
    if (i > num_engineMoves)
         disp(tline)
         string1 = tline;
         userMoves = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\RecMoves.txt','a');
         fprintf(userMoves, '%s\n', string1);
         fclose(userMoves);
         num_engineMoves = i;
    end
    tline = fgetl(engineMoves);
end
fclose(engineMoves);
end
