function [out_img] = image_subtraction(img1 , img2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

size_img = size(img1);
out_img = ones(size_img(1),size_img(2),size_img(3));

for i_slice= 1:size_img(3)
    i_slice
    out_img(:,:,i_slice) = img1(:,:,i_slice) - img2(:,:,i_slice);
end

end

