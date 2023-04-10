function [out] = image_threshold(img, T)
% IMAGE_THRESHOLD Produces a binary image in which pixels at the same location
% in the input % image (img) that had greater values than threshold, T, 
% are  equal to 1 and all other pixels are equal to 0 

[num_row, num_col] = size(img); % Compute the size of the image
out = ones(num_row, num_col); % Preallocate space the size of the image

% Iterate through all rows and columsn of the original image 
for i_row = 1:num_row
    for j_col = 1:num_col
        if img(i_row,j_col) < T
            out(i_row,j_col) = 0; % Set the corresponding pixel in the output image equal to 0 if it is less than the threshold in the original image, img
        end
    end
end

end

