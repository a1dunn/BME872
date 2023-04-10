function [N] = imageQuality_noise(img , method, type, plot_fig)
%IMAGEQUALITY_NOISE Quantifies the noise present in a medical image
%   INPUTS:
%       img: medical image of type double
%       method: method of computing the noise metric.
%           1 = mean of the pre-processed image
%           2 = standard deviation of the pre-processed image
%           3 = mean of the pre-processed image normalized by the standard deviation
%       type: image type
%           0 = CT image in Hounsfields units (HU)
%           1 = MRI image
%       plot_fig: option to plot image figures at every step of the pipeline
%           0 = do not generate plots
%           1 = generate plots
%   OUTPUT:
%       N: Noise metric for the inputted image

min_img = min(min(img)); % Compute the minumum intensity value in the image
max_img = max(max(img)); % Compute the maximum intensity value in the image

% If the image is not normalized between 1 and 0, normalize it
if max(max(img)) > 1 || min(min(img)) < 0
    img = (img-min_img)/(max_img-min_img);
end

% Set the thresholds for edge detection based on the image type
if type == 0
    T = 0.1; % Threshold for edge detection of CT images
elseif type == 1
    T = 0.2; % Threshold for edge detection of MRI images
end

%% Image pre-processing and computing an artificial "isolated noise" image

kernel = fspecial('gaussian', 3, 10); % Create a Gaussian smoothing filter kernel with sigma = 10 and size of 3x3
img_filt = imfilter(img,kernel,'symmetric'); % Blur the image using a Gaussian smoothing filter
kernel = fspecial('gaussian', 3, 5); % Create a Gaussian smoothing filter kernel with sigma = 10 and size of 5x5
img_filt2 = imfilter(img,kernel,'symmetric'); % Blur the image using a Gaussian smoothing filter
img_noise = img-img_filt; % Subtract the Gaussian blurred image (sigma = 10) from the original image
img_noise = img_noise(3:end-2,3:end-2); % Trim the image such that only regions not affected by boundary condition handling remain

%% Compute the edge map

kernel = derivative_kernel('sobel', 'x'); % Obtain a Sobel filtering kernel for detecting x-direction gradients
grad_x = imfilter(img_filt2,kernel,'symmetric'); % Compute x-direction gradient image
kernel = derivative_kernel('sobel', 'y'); % Obtain a Sobel filtering kernel for detecting y-direction gradients
grad_y = imfilter(img_filt2,kernel,'symmetric'); % Compute y-direction gradient image
grad_mag = (grad_x.^2+ grad_y.^2).^(1/2); % Compute gradient magnitude image
grad_mag_norm = normalize(grad_mag,'range'); % Normalize the gradient magnitude image
edge_map = image_threshold(grad_mag_norm, T); % Compute an edge map

% Plot the original, blurred, "noise", x-direction gradient, y-direction gradient,
% and gradient magnitude images
if plot_fig == 1
    figure
    hold on
    title('Original Image')
    imshow(img,[])
    hold off
    
    figure
    hold on
    title('Gaussian Blurred Image')
    imshow(img_filt,[])
    hold off
    
    figure
    hold on
    imshow(img_noise,[])
    title('Artificial "Noise" Image')
    hold off
    
    figure
    hold on
    imshow(grad_x,[])
    title('Horizontal Gradient Image')
    hold off
    
    figure
    hold on
    imshow(grad_y,[])
    title('Vertical Gradient Image')
    hold off
    
        
    figure
    hold on
    imshow(grad_mag,[])
    title('Gradient Magnitude Image')
    hold off
    
    figure
    hold on
    imshow(edge_map,[])
    title('Edge Map')
    hold off
end

%% Threshold the edge map and remove areas that correspond to background regions

[num_row,num_col] = size(edge_map); % Compute the number of rows and columns in the edge map
% For all elements of the edge map, if the intensity in the original image is less than
% the empirically determined threshold for the background of the image,
% set the edge map value equal to 0
for i = 1:num_row
    for j = 1:num_col
        if type == 0 && img(i,j) < 0.3
            edge_map(i,j) = 0;
        end
        if type == 1 && img(i,j) < 0.5
            edge_map(i,j) = 0;
        end
    end
end
edge_map = edge_map(3:end-2,3:end-2); % Trim the edge map such that only regions not affected by boundary condition handling remain

% Plot the edge map with background regions removed
if plot_fig == 1
    figure
    hold on
    imshow(edge_map,[])
    title('Edge Map with Background Removed')
    hold off
end

%% Invert the edge map and apply it to the image
edge_map = ~edge_map; % Invert the 0s and 1s in the edge map
edge_map = double(edge_map); % Convert to double
edge_map(edge_map == 0) = NaN; % Set all values of 0 to NaN
img_noise_masked = img_noise.*edge_map; % Mask the "noise" image using the edge mask

% Plot the masked image
if plot_fig == 1
    figure
    hold on
    imshow(img_noise_masked,[])
    title('Masked Image')
    hold off
end

%% Compute the noise metric according to the selected 
if method ==1
    N = mean(img_noise_masked,'all','omitnan');
elseif method == 2
    N = std(img_noise_masked,1,'all','omitnan');
elseif method == 3
    N = std(img_noise_masked,1,'all','omitnan');
end
end

