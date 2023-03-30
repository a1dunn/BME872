%%% BME 872 LAB 1 PROBLEM 4 %%%

% clear all
% close all
% clc

%% Load all images, convert them to grayscale, and save them into three arrays (one per dataset)

%filepathroot = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 3';
 filepathroot = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz';
 filepaths = {'\diabetic_retinopathy', '\glaucoma', '\healthy'};
 fileabreviations = {'dr', 'g', 'h'};

for dataset = [1 2 3]
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
    
    if dataset == 1
        img_dr = current_array;
    elseif dataset == 2
        img_g = current_array;
    elseif dataset == 3
        img_h = current_array;
    end
end
for dataset = [1 2 3]
    for image_num = 1:15
        if image_num < 10
            current_num = strcat('0',num2str(image_num));
        else
            current_num = num2str(image_num);
        end
        current_img = imread(strcat('C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\healthy_manualsegm','\',current_num,'_',fileabreviations{dataset},'.tif'));
        img_db = im2double(current_img); % converts image into type double
        %grey_img = rgb2gray(img_db);
        current_array(:,:,image_num) = img_db;
    end
    
    if dataset ==1
        img_dr_val = current_array;
    elseif dataset == 2
        img_g_val = current_array;
    elseif dataset == 3
        img_h_val = current_array;
    end
end



%% HEALTHY IMAGE 5
% Apply a smoothing filter to select images
h = [1 4 7 4 1; 4 20 33 20 4; 7 33 55 33 7; 4 20 33 20 4; 1 4 7 4 1];

img_h_s = (1/331).*spatial_filter(img_h(:,:,5),h);
 

% Apply derivative filters to select images
filter_names = {'central' 'forward' 'prewitt' 'sobel'};
filter_num = 4;

[kernel, ~] = derivative_kernel(filter_names{filter_num}, 'x');
grad_x = spatial_filter(img_h_s(:,:),kernel);
[kernel, filter_title] = derivative_kernel(filter_names{filter_num}, 'y');
grad_y = spatial_filter(img_h_s(:,:),kernel);
grad_mag = (grad_y.^2 + grad_x.^2).^(1/2);

out33 = non_max_suppress(grad_mag, 3, 3);

T = 0.06;
out_thresholded = image_threshold(out33, 0.9, T);
figure
hold on
imshow(out_thresholded,[])
title('Retinal Image - Healthy - Frame 5 - Thresholded NMS at 0.06')
hold off

% Moving average to fill vessels
kernel_size = [15, 15];
kernel = ones(kernel_size) / prod(kernel_size);
smoothed_image15 = imfilter(out_thresholded, kernel, 'replicate');
figure
hold on
imshow(smoothed_image15,[])
title('Retinal Image - Healthy - Frame 5 - 15x15 Moving Average')
hold off

% Re-Binarize the image
smoothed_image15 = image_threshold(smoothed_image15, 0.9, 0.015);
figure
hold on
imshow(smoothed_image15,[])
title('Retinal Image - Healthy - Frame 5 - Second Thresholded at 0.015')
hold off
final_image = ~bwareaopen(~smoothed_image15, 2000);
figure
hold on
imshow(final_image,[])
title('Retinal Image - Healthy - Frame 5 - Final Image')
hold off

figure
hold on
imshow(overlay_colour( final_image, img_h_val(:, :, 5), [0, 255, 0], 0.5),[])
title('Retinal Image - Healthy - Frame 5 - Ground Truth Overlay')
hold off
disp("H Dice: ");
calculateDice(img_h_val(:, :, 5), final_image)

%% GLAUCOMA IMAGE 5
% Apply a smoothing filter to select images
h = [1 4 7 4 1; 4 20 33 20 4; 7 33 55 33 7; 4 20 33 20 4; 1 4 7 4 1];

img_g_s = (1/331).*spatial_filter(img_g(:,:,5),h);
 

% Apply derivative filters to select images
filter_names = {'central' 'forward' 'prewitt' 'sobel'};
filter_num = 4;

[kernel, ~] = derivative_kernel(filter_names{filter_num}, 'x');
grad_x_g = spatial_filter(img_g_s(:,:),kernel);
[kernel, filter_title] = derivative_kernel(filter_names{filter_num}, 'y');
grad_y_g = spatial_filter(img_g_s(:,:),kernel);
grad_mag_g = (grad_y_g.^2 + grad_x_g.^2).^(1/2);

out33_g = non_max_suppress(grad_mag_g, 3, 3);

T = 0.04;
out_thresholded_g = image_threshold(out33_g, 0.9, T);
figure
hold on
imshow(out_thresholded_g,[])
title('Retinal Image - Glaucoma - Frame 5 - Thresholded NMS at 0.04')
hold off
% Moving average to fill vessels
kernel_size = [15, 15];
kernel = ones(kernel_size) / prod(kernel_size);
smoothed_image15_g = imfilter(out_thresholded_g, kernel, 'replicate');
figure
hold on
imshow(smoothed_image15_g,[])
title('Retinal Image - Glaucoma - Frame 5 - 15x15 Moving Average')
hold off
% Re-Binarize the image
smoothed_image15_g = image_threshold(smoothed_image15_g, 0.9, 0.08);
figure
hold on
imshow(smoothed_image15_g,[])
title('Retinal Image - Glaucoma - Frame 5 - Second Thresholded at 0.08')
hold off
final_image_g = ~bwareaopen(~smoothed_image15_g, 2000);
figure
hold on
imshow(final_image_g,[])
title('Retinal Image - Glaucoma - Frame 5 - Final Image')
hold off

figure
hold on
imshow(overlay_colour( final_image_g, img_g_val(:, :, 5), [0, 255, 0], 0.5),[])
title('Retinal Image - Glaucoma - Frame 5 - Ground Truth Overlay')
hold off
disp("G Dice: ");
calculateDice(img_g_val(:, :, 5), final_image_g)

%% diabetic_retinopathy IMAGE 5
% Apply a smoothing filter to select images
h = [1 4 7 4 1; 4 20 33 20 4; 7 33 55 33 7; 4 20 33 20 4; 1 4 7 4 1];

img_dr_s(:,:) = (1/331).*spatial_filter(img_dr(:,:,5),h);
 

% Apply derivative filters to select images
filter_names = {'central' 'forward' 'prewitt' 'sobel'};
filter_num = 4;

[kernel, ~] = derivative_kernel(filter_names{filter_num}, 'x');
grad_x_dr = spatial_filter(img_dr_s(:,:),kernel);
[kernel, filter_title] = derivative_kernel(filter_names{filter_num}, 'y');
grad_y_dr = spatial_filter(img_dr_s(:,:),kernel);
grad_mag_dr = (grad_y_dr.^2 + grad_x_dr.^2).^(1/2);

out33_dr = non_max_suppress(grad_mag_dr, 3, 3);
%%
T = 0.04;
out_thresholded_dr = image_threshold(out33_dr, 0.9, T);
figure
hold on
imshow(out_thresholded_dr,[])
title('Retinal Image - Diabetic Retinopathy - Frame 5 - Thresholded NMS at 0.04')
hold off
% Moving average to fill vessels
kernel_size = [15, 15];
kernel = ones(kernel_size) / prod(kernel_size);
smoothed_image15_dr = imfilter(out_thresholded_dr, kernel, 'replicate');
figure
hold on
imshow(smoothed_image15_dr,[])
title('Retinal Image - Diabetic Retinopathy - Frame 5 - 15x15 Moving Average')
hold off
% Re-Binarize the image
smoothed_image15_dr = image_threshold(smoothed_image15_dr, 0.9, 0.12);
figure
hold on
imshow(smoothed_image15_dr,[])
title('Retinal Image - Diabetic Retinopathy - Frame 5 - Second Thresholded at 0.08')
hold off
final_image_dr = ~bwareaopen(~smoothed_image15_dr, 2000);
figure
hold on
imshow(final_image_dr,[])
title('Retinal Image - Diabetic Retinopathy - Frame 5 - Final Image')
hold off

figure
hold on
%imshow(final_image_dr, []);
imshow(overlay_colour( final_image_dr, img_dr_val(:, :, 5), [0, 255, 0], 0.5),[])
title('Retinal Image - Diabetic Retinopathy - Frame 5 - Ground Truth Overlay')
hold off
disp("DR Dice: ");
calculateDice(img_dr_val(:, :, 5), final_image_dr)



    

