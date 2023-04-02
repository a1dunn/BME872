%%% BME 872 LAB 1 PROBLEM 2.1 %%%

clear all
close all
clc

%% Load all images, convert them to grayscale, and save them into three arrays (one per dataset)

filepathroot = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 3';
filepaths = {'\diabetic_retinopathy', '\glaucoma', '\healthy'};
fileabreviations = {'dr', 'g', 'h'};

for dataset = 1:3
    for image_num = 1:15
        if image_num < 10
            current_num = strcat('0',num2str(image_num));
        else
            current_num = num2str(image_num);
        end
        current_img = imread(strcat(filepathroot,filepaths{dataset},'\',current_num,'_',fileabreviations{dataset},'.jpg'));
        img_db = im2double(current_img); % converts image into type double
        grey_img = rgb2gray(img_db);
        current_array(:,:,image_num) = grey_img;
    end
    
    if dataset ==1
        img_dr = current_array;
    elseif dataset == 2
        img_g = current_array;
    elseif dataset == 3
        img_h = current_array;
    end
end

%% Apply a smoothing filter to image 5 from each dataset

i_slice = 5;
h = [1 4 7 4 1; 4 20 33 20 4; 7 33 55 33 7; 4 20 33 20 4; 1 4 7 4 1];
img_h_s = (1/331).*spatial_filter(img_h(:,:,i_slice),h);
img_g_s = (1/331).*spatial_filter(img_g(:,:,i_slice),h);
img_dr_s = (1/331).*spatial_filter(img_g(:,:,i_slice),h);

%% Plot the original images and smoothed images

figure
subplot(1,2,1)
hold on
title(strcat('Original Retinal Image - Healthy - Frame', 32, num2str(i_slice)))
imshow(img_h(:,:,i_slice),[])
xlim([800 1800])
ylim([1500 2500])
hold off
subplot(1,2,2)
hold on
title(strcat('Smoothed Retinal Image - Healthy - Frame', 32, num2str(i_slice)))
imshow(img_h_s,[])
xlim([800 1800])
ylim([1500 2500])
hold off

figure
subplot(1,2,1)
hold on
title(strcat('Original Retinal Image - Healthy - Frame', 32, num2str(i_slice)))
imshow(img_h(:,:,i_slice),[])
hold off
subplot(1,2,2)
hold on
title(strcat('Smoothed Retinal Image - Healthy - Frame', 32, num2str(i_slice)))
imshow(img_h_s,[])
hold off

figure
subplot(1,2,1)
hold on
title(strcat('Original Retinal Image - Glaucoma - Frame', 32, num2str(i_slice)))
imshow(img_g(:,:,i_slice),[])
xlim([800 1800])
ylim([1500 2500])
hold off
subplot(1,2,2)
hold on
title(strcat('Smoothed Retinal Image - Glaucoma - Frame', 32, num2str(i_slice)))
imshow(img_g_s,[])
xlim([800 1800])
ylim([1500 2500])
hold off

figure
subplot(1,2,1)
hold on
title(strcat('Original Retinal Image - Glaucoma - Frame', 32, num2str(i_slice)))
imshow(img_g(:,:,i_slice),[])
hold off
subplot(1,2,2)
hold on
title(strcat('Smoothed Retinal Image - Glaucoma - Frame', 32, num2str(i_slice)))
imshow(img_g_s,[])
hold off

figure
subplot(1,2,1)
hold on
title(strcat('Original Retinal Image - Diabetic Retinopathy - Frame', 32, num2str(i_slice)))
imshow(img_g(:,:,i_slice),[])
xlim([800 1800])
ylim([1500 2500])
hold off
subplot(1,2,2)
hold on
title(strcat('Smoothed Retinal Image - Diabetic Retinopathy - Frame', 32, num2str(i_slice)))
imshow(img_g_s,[])
xlim([800 1800])
ylim([1500 2500])
hold off

figure
subplot(1,2,1)
hold on
title(strcat('Original Retinal Image - Diabetic Retinopathy - Frame', 32, num2str(i_slice)))
imshow(img_g(:,:,i_slice),[])
hold off
subplot(1,2,2)
hold on
title(strcat('Smoothed Retinal Image - Diabetic Retinopathy - Frame', 32, num2str(i_slice)))
imshow(img_g_s,[])
hold off

%% Apply derivative filters

filter_names = {'central' 'forward' 'prewitt' 'sobel'};

for filter_num = 4
    
    % Apply x-direction kernel
    [kernel, ~] = derivative_kernel(filter_names{filter_num}, 'x');
    grad_x_h = spatial_filter(img_h_s,kernel);
    grad_x_g = spatial_filter(img_g_s,kernel);
    grad_x_dr = spatial_filter(img_dr_s,kernel);
    % Apply y-direction kernel
    [kernel, filter_title] = derivative_kernel(filter_names{filter_num}, 'y');
    grad_y_h = spatial_filter(img_h_s,kernel);
    grad_y_g = spatial_filter(img_g_s,kernel);
    grad_y_dr = spatial_filter(img_dr_s,kernel);
    % Calculate gradient magnitude
    grad_mag_h = (grad_y_h.^2 + grad_x_h.^2).^(1/2);
    grad_mag_g = (grad_y_g.^2 + grad_x_g.^2).^(1/2);
    grad_mag_dr = (grad_y_dr.^2 + grad_x_dr.^2).^(1/2);
    
    % Plot results for the image from the healthy dataset
    figure
    subplot(1,3,1)
    hold on
    imshow(grad_x_h,[])
    xlim([800 1800])
    ylim([1500 2500])
    title('X-Gradient')
    hold off
    subplot(1,3,2)
    hold on
    imshow(grad_y_h,[])
    xlim([800 1800])
    ylim([1500 2500])
    title('Y-Gradient')
    hold off
    subplot(1,3,3)
    hold on
    imshow(grad_mag_h,[])
    xlim([800 1800])
    ylim([1500 2500])
    title('Gradient Magnitude')
    hold off
    sgtitle(strcat('Retinal Image - Healthy - Frame', 32, num2str(i_slice), 32, '- Kernel:', 32, filter_title))
    
    figure
    subplot(1,3,1)
    hold on
    imshow(grad_x_h,[])
    title('X-Gradient')
    hold off
    subplot(1,3,2)
    hold on
    imshow(grad_y_h,[])
    title('Y-Gradient')
    hold off
    subplot(1,3,3)
    hold on
    imshow(grad_mag_h,[])
    title('Gradient Magnitude')
    hold off
    sgtitle(strcat('Retinal Image - Healthy - Frame', 32, num2str(i_slice), 32, '- Kernel:', 32, filter_title))
    
    % Plot results for the image from the glaucoma dataset
    figure
    subplot(1,3,1)
    hold on
    imshow(grad_x_g,[])
    xlim([800 1800])
    ylim([1500 2500])
    title('X-Gradient')
    hold off
    subplot(1,3,2)
    hold on
    imshow(grad_y_g,[])
    xlim([800 1800])
    ylim([1500 2500])
    title('Y-Gradient')
    hold off
    subplot(1,3,3)
    hold on
    imshow(grad_mag_g,[])
    xlim([800 1800])
    ylim([1500 2500])
    title('Gradient Magnitude')
    hold off
    sgtitle(strcat('Retinal Image - Glaucoma - Frame', 32, num2str(i_slice), 32, '- Kernel:', 32, filter_title))
    
    figure
    subplot(1,3,1)
    hold on
    imshow(grad_x_g,[])
    title('X-Gradient')
    hold off
    subplot(1,3,2)
    hold on
    imshow(grad_y_g,[])
    title('Y-Gradient')
    hold off
    subplot(1,3,3)
    hold on
    imshow(grad_mag_g,[])
    title('Gradient Magnitude')
    hold off
    sgtitle(strcat('Retinal Image - Glaucoma - Frame', 32, num2str(i_slice), 32, '- Kernel:', 32, filter_title))
    
    % Plot results for the image from the Diabetic Retinopathy dataset
    figure
    subplot(1,3,1)
    hold on
    imshow(grad_x_dr,[])
    xlim([800 1800])
    ylim([1500 2500])
    title('X-Gradient')
    hold off
    subplot(1,3,2)
    hold on
    imshow(grad_y_dr,[])
    xlim([800 1800])
    ylim([1500 2500])
    title('Y-Gradient')
    hold off
    subplot(1,3,3)
    hold on
    imshow(grad_mag_dr,[])
    xlim([800 1800])
    ylim([1500 2500])
    title('Gradient Magnitude')
    hold off
    sgtitle(strcat('Retinal Image - Diabetic Retinopathy - Frame', 32, num2str(i_slice), 32, '- Kernel:', 32, filter_title))
    
    figure
    subplot(1,3,1)
    hold on
    imshow(grad_x_dr,[])
    title('X-Gradient')
    hold off
    subplot(1,3,2)
    hold on
    imshow(grad_y_dr,[])
    title('Y-Gradient')
    hold off
    subplot(1,3,3)
    hold on
    imshow(grad_mag_dr,[])
    title('Gradient Magnitude')
    hold off
    sgtitle(strcat('Retinal Image - Diabetic Retinopathy - Frame', 32, num2str(i_slice), 32, '- Kernel:', 32, filter_title))
    
end

close all

%% Apply non-maxima suppression
nms33_h = non_max_suppress(grad_mag_h, 3, 3);
nms33_g = non_max_suppress(grad_mag_g, 3, 3);
nms33_dr = non_max_suppress(grad_mag_dr, 3, 3);

%% Normalize NMS images between 0 and 1
nms_h_norm = normalize(nms33_h, 'range');
nms_g_norm = normalize(nms33_g, 'range');
nms_dr_norm = normalize(nms33_dr, 'range');

%% PROBLEM 2.3: Apply thresholds

for T = [0.25 0.5 0.75]
    
    % Threshold images
    img_thresh_h = image_threshold(nms_h_norm,T);
    img_thresh_g = image_threshold(nms_g_norm,T);
    img_thresh_dr = image_threshold(nms_dr_norm,T);
    
    % Plot thresholded images
    figure
    hold on
    imshow(img_thresh_h,[])
    title(strcat('Thresholded NMS Image - Healthy - T =', 32, num2str(T)))
    hold off
    
    figure
    hold on
    imshow(img_thresh_h,[])
    title(strcat('Thresholded NMS Image - Healthy - T =', 32, num2str(T)))
    xlim([800 1800])
    ylim([1500 2500])
    hold off
    
    figure
    hold on
    imshow(img_thresh_g,[])
    title(strcat('Thresholded NMS Image - Glaucoma - T =', 32, num2str(T)))
    hold off
    
    figure
    hold on
    imshow(img_thresh_g,[])
    title(strcat('Thresholded NMS Image - Glaucoma - T =', 32, num2str(T)))
    xlim([800 1800])
    ylim([1500 2500])
    hold off
    
    figure
    hold on
    imshow(img_thresh_dr,[])
    title(strcat('Thresholded NMS Image - Diabetic Retinopathy - T =', 32, num2str(T)))
    hold off
    
    figure
    hold on
    imshow(img_thresh_dr,[])
    title(strcat('Thresholded NMS Image - Diabetic Retinopathy - T =', 32, num2str(T)))
    xlim([800 1800])
    ylim([1500 2500])
    hold off
    
end

%% PROBLEM 2.5: Bonus question thresholds
close all
clc
% Threshold image
T = automatic_threshold(nms33_h);
img_thresh_h = image_threshold(nms33_h,T);

% Plot thresholded images
figure
hold on
imshow(img_thresh_h,[])
title(strcat('Thresholded NMS Image - Healthy - T =', 32, num2str(T)))
hold off

figure
hold on
imshow(img_thresh_h,[])
title(strcat('Thresholded NMS Image - Healthy - T =', 32, num2str(T)))
xlim([800 1800])
ylim([1500 2500])
hold off

% Threshold image
T = automatic_threshold(nms33_g);
img_thresh_g = image_threshold(nms33_h,T);

figure
hold on
imshow(img_thresh_g,[])
title(strcat('Thresholded NMS Image - Glaucoma - T =', 32, num2str(T)))
hold off

figure
hold on
imshow(img_thresh_g,[])
title(strcat('Thresholded NMS Image - Glaucoma - T =', 32, num2str(T)))
xlim([800 1800])
ylim([1500 2500])
hold off

% Threshold image
T = automatic_threshold(nms33_dr);
img_thresh_dr = image_threshold(nms33_dr,T);

figure
hold on
imshow(img_thresh_dr,[])
title(strcat('Thresholded NMS Image - Diabetic Retinopathy - T =', 32, num2str(T)))
hold off

figure
hold on
imshow(img_thresh_dr,[])
title(strcat('Thresholded NMS Image - Diabetic Retinopathy - T =', 32, num2str(T)))
xlim([1200 2200])
ylim([1500 2500])
hold off