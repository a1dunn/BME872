function [out] = image_threshold(img , Tupper, Tlower)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[num_row, num_col] = size(img);

for i_row = 1:num_row
    for j_col = 1:num_col
        if img(i_row,j_col) > Tupper
            img(i_row,j_col) = 0;
        end
    end
end

[num_row, num_col] = size(img);
out = ones(num_row, num_col);

for i_row = 1:num_row
    for j_col = 1:num_col
        if img(i_row,j_col) < Tlower
            out(i_row,j_col) = 0;
        end
    end
end

end

