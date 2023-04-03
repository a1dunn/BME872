function [E] = imageQuality_edge(img, sigma, threshold)
% Compute edge quality metric for input images
% imgs: input 3D image
% plotting: if 'plot', display edge quality metric plot
%% Gaussian Filtering
% Create 2D Gaussian kernel
kernel_size = ceil(6*sigma);
if mod(kernel_size, 2) == 0
    kernel_size = kernel_size + 1;
end
kernel = fspecial('gaussian', kernel_size, sigma);

img = img - min(min(img));
img = 256*img/max(max(img));
% Apply filter to each slice in image
filtered_image = zeros(size(img));

filtered_image(:, :) = imfilter(img, kernel, 'same', 'replicate');


sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];


% Apply the Sobel kernels
dx = conv2(filtered_image, sobel_x, 'same');
dy = conv2(filtered_image, sobel_y, 'same');

% Calculate gradient magnitude
grad_mag(:, :) = (dy.^2 + dx.^2).^(1/2);

sum_above_thresh = sum(grad_mag(grad_mag > threshold));
num_above_thresh = sum(grad_mag(:) > threshold);
% Compute edge quality metric for each slice in filtered image
E = sum_above_thresh/num_above_thresh;
end
