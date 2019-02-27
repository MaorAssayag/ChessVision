%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [ img_borad,imagePoints_end,imagePoints_start,flag_rotate,flag_find ] = GetReadyForTheGame( I )
% This function is aid function for the main code. The output is the the 
% final board image after transformations & the points of intersections (with some stats).
% Input : rgb or grayscale image - a snapshot of the camera, [N*M*3] or [N*M]
% Outputs : img - extraction of the chess board in the frame [Q*Q*3] (Q=min{N,M})
%           imagePoints_end - [49*2]   - the corrners of the squares in the
%           chessboard
flag_find=true;
flag_rotate=true;
img_borad=I;
imagePoints_end=[0,0];
[imagePoints_start,~,flag_first_detection]=GetImagePoints(I);
%%
if ~flag_first_detection

    Perspective_img=geometric_transformation(I,imagePoints_start);

%%
    [imagePoints_sec,~,flag_sec_detection] = GetImagePoints(Perspective_img);

    if ~flag_sec_detection
        mean_mat_64=img2meansquares(Perspective_img,imagePoints_sec);
        [img_borad,flag_rotate]=rotate_if_necessary(Perspective_img,mean_mat_64);
        if flag_rotate
            [imagePoints_end,~,flag_third_detection] = GetImagePoints(img_borad);
            if flag_third_detection
                disp('the detectCheckerboardPoints fail to find the board - third_detection');
                flag_find=false;
            end
            
        else 
            imagePoints_end=imagePoints_sec;
        end % flag_rotate
    else
        disp('the detectCheckerboardPoints fail to find the board - sec_detection');
        flag_find=false;
    end %~flag_sec_detection
else
    disp('the detectCheckerboardPoints fail to find the board - first_detection');
    flag_find=false;
end %~flag_first_detection

end