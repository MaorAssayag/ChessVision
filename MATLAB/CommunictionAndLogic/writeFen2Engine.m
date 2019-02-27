%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [llegal] = writeFen2Engine(FEN)
    fenFile = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\FEN.txt','w');
    fprintf(fenFile, '%s\n', FEN);
    fclose(fenFile);
    
    fenFile = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\FEN.txt','r');
    tline = fgetl(fenFile);
    i = 0;
    while ~ischar(tline) || i < 1
        if ischar(tline)  
            i = i + 1;
        end
        tline = fgetl(fenFile);
    end
    result = tline;
    fclose(fenFile);
    llegal = (result == "llegal position");
end

