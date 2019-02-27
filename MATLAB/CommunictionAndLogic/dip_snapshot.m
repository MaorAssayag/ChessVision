%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function image  = dip_snapshot(cam)
% This function created to improve the stabillity of the camera hardware.
    while 1
        try
            image = snapshot(cam);
            break;  
        catch ME
            clear('cam');
            cam = webcam(2);
            cam.Resolution = '1280x800';
            cam.Exposure = -9;
            cam.Sharpness = 50;
            disp('catch')
        end     
    end
end

