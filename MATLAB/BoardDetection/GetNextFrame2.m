%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [new_frame, ResetFlag] = GetNextFrame2(old_img,cam,imagePoints_start,flag_rotate,num)
%the function get:
%old_img [N*M*3] or [N*M]
%v - videoReader

%the function return new image (after move)

old_board_img=GetOnlyBoard(old_img,imagePoints_start,flag_rotate);

old_img_gray=double(img2gray(old_board_img));
last_img=old_img_gray;
flag_low_change=true;

while flag_low_change
    pause(0.2);
    if checkReset()
        ResetFlag = 1;
        break;
    else
        ResetFlag = 0;
    end
    test_fram = dip_snapshot(cam);
    test_fram=GetOnlyBoard(test_fram,imagePoints_start,flag_rotate);
    test_fram_d_gray=double(img2gray(test_fram));
    
    sub_test_last=abs(test_fram_d_gray-last_img);
    if max(sub_test_last(:))>100
        flag_low_change=false;
    end
    
    last_img=test_fram_d_gray;
end %while flag_low_change

%%
flag_change=true;

while flag_change
    pause(num/30);
    test_fram = dip_snapshot(cam);
    new_frame=test_fram;
    
    test_fram=GetOnlyBoard(test_fram,imagePoints_start,flag_rotate);
    
    test_fram_d_gray=double(img2gray(test_fram));
    
    sub_test_last=abs(test_fram_d_gray-last_img);
    if max(sub_test_last(:))<80
        flag_change=false;
    end
    
    last_img=test_fram_d_gray;
end %while flag_low_change
%%
end

