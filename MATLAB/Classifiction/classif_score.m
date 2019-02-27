function [score] = classif_score(img, m, type_square)
%CLASSIF_SCORE Summary of this function goes here
%   Detailed explanation goes here
    [labelIdx, scores] = predict(m.categoryClassifier, img);
    % Display the string label
    %label = m.categoryClassifier.Labels(labelIdx);
    
    % adjust the type from board represention to categroy represention
    index = find( strcmp(m.categoryClassifier.Labels, adjust_types(type_square)) );
    score = scores(index);
end

