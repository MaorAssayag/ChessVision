%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [points, boardSize] = detectCheckerboardInOneImageMy(I,th)
% This function returns the points of the inner 7x7 intersection of a 8x8
% checker board using the internal detectCheckerboard MATLAB function.
% Inputs : I - an image (snapshot of the camera)
%          th - internal threshold for detectCheckerboard function
% Outputs: points - the corrners of the squares in the
%                   chessboard
%          boardSize - boardsize detecetd (8x8 etc)
if size(I, 3) > 1    % check if the imaeg is a gray scale 
    I = rgb2gray(I);
end
I = im2single(I);

% Bandwidth of the gaussian filter for corner detection
% If a checkerboard is not detected in a high-resolution image, increase
% the value of sigma
sigma = 2; 

[points, boardSize] = vision.internal.calibration.checkerboard.detectCheckerboard(...
    I, sigma, th);
end 

