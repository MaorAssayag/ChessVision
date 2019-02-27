%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
clear all;

%% step 1 :  split to categories
rootFolder = fullfile("", 'PiecesDataset'); % define output folder
validFolder = fullfile("", 'EmptysquaresDataset'); % define output folder
% %%%%%%%%%%%%%%%%%%%%%%% add new label == folder name
categories = {'b','bb','nn','n','p','pp','q','qq','r','rr','k','kk'};

% %%%%%%%%%%%%%%%%%%%%%%
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
valid_ds = imageDatastore(fullfile(validFolder, categories), 'LabelSource', 'foldernames');
tbl = countEachLabel(imds)

%% step 2: Separate the sets into training and validation data (30% and 70%)

%%%%%%%%%%%%%%%% for slit fot valid and train
%[trainingSet, validationSet] = splitEachLabel(imds, 0.85, 'randomize');
%%%%%%%%%%%%%%%%%%%%

trainingSet = imds;
validationSet = valid_ds;

%% step 3: Create a Visual Vocabulary and Train an Image Category Classifier
extractor = @exampleBagOfFeaturesExtractor;
%bag = bagOfFeatures(imds,'CustomExtractor',extractor);
bag = bagOfFeatures(imds,'PointSelection','Detector');
%% Training an image category classifier for the categories.
%%%%%%%%%% create new categoryClassifier and save it
categoryClassifier = trainImageCategoryClassifier(trainingSet, bag);
save('categoryClassifier7.mat','-v7.3');
%% Test with the trainingSet and validationSet
%%%%%%%%%%%%%%%%%%%%%%%  test 
confMatrix = evaluate(categoryClassifier, trainingSet);
%confMatrix = evaluate(categoryClassifier, validationSet);