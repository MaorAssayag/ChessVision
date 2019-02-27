%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [label] = classif(img, m)
%CLASSIF Summary of this function goes here
%   Detailed explanation goes here
    %load('categoryClassifier5.mat');
    %load('categoryClassifier6.mat');
    [labelIdx, scores] = predict(m.categoryClassifier, img);
    % Display the string label
    label = m.categoryClassifier.Labels(labelIdx);
end

