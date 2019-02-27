%img = imread('2.jpg');
[time,n] = HandGestureDetection(hand,1);
%%

TimeSum = 0;
AccurecySum = zeros(5,5);
j = 0;
for j = 1:5
    for i = 1:10
        current_img = imread(sprintf('%d_%d.jpg',j,i));
        [time, n] = HandGestureDetection(current_img,0);
        TimeSum = TimeSum + time;
        AccurecySum(j,n) = AccurecySum(j,n) + 1;
    end
end
%%
display('Analysis of 5 images, 10 times')
display(['Average Time : ',num2str(TimeSum/50), 's'])
display(['Accurecy : ', num2str(AccurecySum/0.5), '%'])
%%

% Open image
I = imread('image_0011.jpg');
% Convert to grayscale
I = rgb2gray(I);
% Show image
figure(1);
imshow(I)
title('Image with objects')
% mask is the initial contour state
mask = zeros(size(I));
mask(25:end-25,25:end-25) = 1;
% Show mask
figure(2);
imshow(mask);
title('Initial contour location')
% bw is a mask of the detected objects
numIter = 2500;
bw = activecontour(I, mask, numIter);
% Show detected objects
figure(3);
imshow(bw);
title('Detected objects')
%%

% Wait for the engine to finish - blocking the matlab code from continution
resetFile = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\Reset.txt','r');
tline = fgetl(resetFile);
if (tline ~= -1)
    % The game is in reset mode - reset the file itselef
    fclose(resetFile);
    resetFile = fopen('C:\Users\MaorA\PycharmProjects\untitled1\venv\Reset.txt','w');

end
fclose(resetFile);

%%
board = zeros(8,8);
for i = 1:64
    board(i) = i;
end
board
%%
clear all
close all
clc
cam = webcam(2);
cam.Resolution = '1280x800';
cam.Exposure = -7;
cam.Sharpness = 50;
%%
TimeSum = 0;
AccurecySum = zeros(4,4);
j = 0;
for j = 1:4
    j
    for i = 1:10
        [time, skill_level] = HandRecognition(cam);
        TimeSum = TimeSum + time;
        AccurecySum(j,skill_level) = AccurecySum(j,skill_level) + 1;
        pause(2);
        skill_level
        i
    end
end
AccurecySum = AccurecySum/10;
