function [] = imageWrite(path, imageFormat, img, filename, varargin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

cd(path);
size_array = size(img);

if length(size(img)) == 2
   size_array = [size_array NaN]; 
end

num_fr = size_array(3);

if num_fr > 0 
    for i_frame_num = 1:num_fr
        if i_frame_num<10
            filename_save = strcat(filename, '_00', num2str(i_frame_num),imageFormat);
        else
            filename_save = strcat(filename, '_0', num2str(i_frame_num),imageFormat);
        end
        if strcmp(imageFormat, '.dcm')
            dicomwrite(img(:,:,i_frame_num),filename_save,varargin{1,1}(i_frame_num));
        elseif strcmp(imageFormat, '.png')
        end
    end
else
    if strcmp(imageFormat, '.png')
        img_shifted = img - min(min(img));
        img_shifted_uint16 = uint16(img_shifted);
        imwrite(img_shifted_uint16,strcat(filename,'.png'));
    end
end

end

