%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [ img_borad,imagePoints_end,imagePoints_start,flag_rotate,flag_find ] = GetReadyForTheGame( I )
%the function get:
%img - [N*M*3] or [N*M]

%the function return
%img - [Q*Q*3] (Q=min{N,M}) - only the chess board
%imagePoints_end - [49*2]   - the corrner of the squares

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

