function [E] = imageQuality_edge(imgs, plotting)
% Compute edge quality metric for input images
% imgs: input 3D image
% plotting: if 'plot', display edge quality metric plot
E = zeros(size(imgs, 3), size(imgs, 4));
for variations = 1:size(imgs, 4)
    variations
    %% Gaussian Filtering
    sigma = 2;
    % Create 2D Gaussian kernel
    kernel_size = ceil(6*sigma);
    if mod(kernel_size, 2) == 0
        kernel_size = kernel_size + 1;
    end
    kernel = fspecial('gaussian', kernel_size, sigma);

    % Apply filter to each slice in image
    filtered_image = zeros(size(imgs(:, : , :, variations)));
    for i = 1:size(imgs, 3)
        filtered_image(:, :, i) = imfilter(imgs(:, :, i, variations), kernel, 'same', 'replicate');
    end


    sobel_x = [-1 0 1; -2 0 2; -1 0 1];
    sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];
    threshold = 50;
    
    for i = 1:size(imgs, 3)
        % Apply the Sobel kernels
        dx = conv2(imgs(:, : , i, variations), sobel_x, 'same');
        dy = conv2(imgs(:, : , i, variations), sobel_y, 'same');

        % Calculate gradient magnitude
        grad_mag(:, :, i) = (dy.^2 + dx.^2).^(1/2);
        sum_above_thresh = sum(grad_mag(grad_mag > threshold));
        num_above_thresh = sum(grad_mag(:) > threshold);
        % Compute edge quality metric for each slice in filtered image
        E(i, variations) = sum_above_thresh/num_above_thresh;
    end


    


    

end

% Display edge quality metric plot if requested
if strcmp(plotting, 'plot')
    figure;
    % Create a scatter plot with small dots
    scatter(repelem(1:4, 286), E(:), 1, 'filled');

    % Set the axis labels and title
    xlabel('Slice number');
    ylabel('Edge quality');
    title('Edge quality metric');
end
end