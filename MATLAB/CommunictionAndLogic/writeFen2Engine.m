%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [llegal] = writeFen2Engine(FEN)
% This function write the initial position detected to the python code
% and gets a legallity feedback of the inital position (legallity loop
% until the position is legal)
% Input :  FEN -  Formal string represention of a position in chess
% Output : llegal - bolean flag   
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