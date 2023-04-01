function [img_out] = spatial_filter(img,h)
%SPATIAL_FILTER Applies a spatial fiter to an image
%   Inputs:
%       img: input greyscale image begin processed
%       h: filtering kernel
%   Outputs:
%       img_out: filtered grayscale image

[num_row_img, num_col_img] = size(img);
[num_row_h, num_col_h] = size(h);
n_add_row = (num_row_h-1)/2;
n_add_col = (num_col_h-1)/2;

img_out = zeros(num_row_img, num_col_img);
img_expanded = zeros(num_row_img+(2*n_add_row), num_col_img+(2*n_add_col));
img_expanded((1+n_add_row):(1+n_add_row+num_row_img-1), (1+n_add_col):(1+n_add_col+num_col_img-1)) = img;

add_row_top = img(1:n_add_row,:);
add_row_top = flip(add_row_top,1);
img_expanded(1:n_add_row,n_add_col+1:n_add_col+num_col_img) = add_row_top;
add_row_bottom = img(num_row_img-n_add_row+1:num_row_img,:);
add_row_bottom = flip(add_row_bottom,1);
img_expanded(end-n_add_row+1:end,n_add_col+1:n_add_col+num_col_img) = add_row_bottom;
add_col_left = img_expanded(:,1+n_add_col:n_add_col+n_add_col);
add_col_left = flip(add_col_left,2);
img_expanded(:,1:n_add_col) = add_col_left;
add_col_right = img_expanded(:,num_col_img+1:num_col_img+n_add_col);
add_col_right = flip(add_col_right,2);
img_expanded(:,end-n_add_col+1:end) = add_col_right;

h_rot = rot90(h,2);
%% Apply spatial filter

for i_row = 1:num_row_img
    i_row
    for j_col = 1:num_col_img
        current_conv = conv2(img_expanded(i_row:i_row+num_row_h-1,j_col:j_col+num_col_h-1), h_rot, 'same');
        img_out(i_row,j_col) = current_conv(1+n_add_row,1+n_add_col);
        %img_out(row_count,col_count) = sum(sum(h.*img_expanded(i_row:i_row+num_row_h-1,j_col:j_col+num_col_h-1)));
    end
end

end