%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [time, skill_level] = HandRecognition(cam)
%% Recognize when a hand apper in the scene
[y,Fs] = audioread('hand_recognition.ogg');
FlagBlankImage = 1;
while FlagBlankImage
    sound(y,Fs); % % Make a sound of hand recognition
    disp('hand recognition');
    crop_x_init = 520;
    crop_y_init = 0;
    crop_x_size = 400;
    crop_y_size = 1280;
    intial_image = imcrop(dip_snapshot(cam), [crop_x_init, crop_y_init, crop_x_size, crop_y_size]);
    intial_image_gray = double(rgb2gray(intial_image));
    while 1
        new_m = imcrop(dip_snapshot(cam), [crop_x_init, crop_y_init, crop_x_size, crop_y_size]);
        new_im_gray = double(rgb2gray(new_m));
        sub = abs(intial_image_gray - new_im_gray);
        if (max(sub(:)) > 120)
            break
        end
        pause(0.2)
    end
    pause(0.5)
    new_m = imcrop(dip_snapshot(cam), [crop_x_init, crop_y_init, crop_x_size, crop_y_size]);

    % Count the number of fingers
    figure;
    imshow(new_m);
    [time, skill_level, FlagBlankImage] = HandGestureDetection(new_m, 1);
end
end

