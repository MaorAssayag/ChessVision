%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [score] = classif_score(img, m, type_square)
% Gets the score of the square according to the type_square needed
% Inputs : img - 100x100 square image of the piece
%          m - Classifier object
%          type_square - type to be lookfor, represention in the docs
% Output : score - negative score represent how much the img look like the type_square requird 

    [labelIdx, scores] = predict(m.categoryClassifier, img);
    % Display the string label
    %label = m.categoryClassifier.Labels(labelIdx);
    
    % adjust the type from board represention to categroy represention
    index = find( strcmp(m.categoryClassifier.Labels, adjust_types(type_square)) );
    score = scores(index);
end

