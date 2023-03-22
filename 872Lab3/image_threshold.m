function [out] = image_threshold(img , T)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[num_row, num_col] = size(img);
out = img;

for i_row = 1:num_row
    for j_col = 1:num_col
        if img(i_row,i_col) < T
            out(i_row,i_col) = 0;
        end
    end
end

end

