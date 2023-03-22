%%% BME 872 LAB 1 PROBLEM 2.1 %%%

% clear all
% close all
% clc
%
% %% Load all images, convert them to grayscale, and save them into three arrays (one per dataset)
%
% filepathroot = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 3';
% filepaths = {'\diabetic_retinopathy', '\glaucoma', '\healthy'};
% fileabreviations = {'dr', 'g', 'h'};
%
% for dataset = 3
%     for image_num = 1:15
%         if image_num < 10
%             current_num = strcat('0',num2str(image_num));
%         else
%             current_num = num2str(image_num);
%         end
%         current_img = imread(strcat(filepathroot,filepaths{dataset},'\',current_num,'_',fileabreviations{dataset},'.jpg'));
%         img_db = im2double(current_img); % converts image into type double
%         grey_img = rgb2gray(img_db);
%         current_array(:,:,image_num) = grey_img;
%     end
%
%     if dataset ==1
%         img_dr = current_array;
%     elseif dataset == 2
%         img_g = current_array;
%     elseif dataset == 3
%         img_h = current_array;
%     end
% end

%% Apply thresholds

filter_names = {'central' 'forward' 'prewitt' 'sobel'};
save_slice_loc = 1;
for i_slice = [5]
    filter_num = 4;
    
    [kernel, ~] = derivative_kernel(filter_names{filter_num}, 'x');
    grad_x = spatial_filter(img_h_s(:,:,save_slice_loc),kernel);
    [kernel, filter_title] = derivative_kernel(filter_names{filter_num}, 'y');
    grad_y = spatial_filter(img_h_s(:,:,save_slice_loc),kernel);
    grad_mag = (grad_y.^2 + grad_x.^2).^(1/2);
    
    %% Plot x gradient, y gradient, and gradient magnitude
    
    figure
    subplot(1,3,1)
    hold on
    imshow(grad_x,[])
    xlim([800 1800])
    ylim([1500 2500])
    title('X-Gradient')
    hold off
    subplot(1,3,2)
    hold on
    imshow(grad_y,[])
    xlim([800 1800])
    ylim([1500 2500])
    title('Y-Gradient')
    hold off
    subplot(1,3,3)
    hold on
    imshow(grad_mag,[])
    xlim([800 1800])
    ylim([1500 2500])
    title('Gradient Magnitude')
    hold off
    sgtitle(strcat('Retinal Image - Healthy - Frame', 32, num2str(i_slice), 32, '- Kernel:', 32, filter_title))
    
    figure
    subplot(1,3,1)
    hold on
    imshow(grad_x,[])
    title('X-Gradient')
    hold off
    subplot(1,3,2)
    hold on
    imshow(grad_y,[])
    title('Y-Gradient')
    hold off
    subplot(1,3,3)
    hold on
    imshow(grad_mag,[])
    title('Gradient Magnitude')
    hold off
    sgtitle(strcat('Retinal Image - Healthy - Frame', 32, num2str(i_slice), 32, '- Kernel:', 32, filter_title))
    
    %% Plot non-maximum suppression results
    
    out33 = non_max_suppress(grad_mag, 3, 3);
    out77 = non_max_suppress(grad_mag, 7, 7);
    out37 = non_max_suppress(grad_mag, 3, 7);
    
    figure
    subplot(1,2,1)
    hold on
    imshow(grad_mag,[])
    title('Original Gradient Magnitude')
    hold off
    subplot(1,2,2)
    hold on
    imshow(out33,[])
    title('Non-Maxima Suppression with 3x3 Window')
    hold off
    sgtitle(strcat('Retinal Image - Healthy - Frame', 32, num2str(i_slice), 32, '- Kernel:', 32, filter_title))
    
    figure
    subplot(1,2,1)
    hold on
    imshow(grad_mag,[])
    title('Original Gradient Magnitude')
    hold off
    subplot(1,2,2)
    hold on
    imshow(out77,[])
    title('Non-Maxima Suppression with 7x7 Window')
    hold off
    sgtitle(strcat('Retinal Image - Healthy - Frame', 32, num2str(i_slice), 32, '- Kernel:', 32, filter_title))
    
    figure
    subplot(1,2,1)
    hold on
    imshow(grad_mag,[])
    title('Original Gradient Magnitude')
    hold off
    subplot(1,2,2)
    hold on
    imshow(out37,[])
    title('Non-Maxima Suppression with 3x7 Window')
    hold off
    sgtitle(strcat('Retinal Image - Healthy - Frame', 32, num2str(i_slice), 32, '- Kernel:', 32, filter_title))
    
    %% Apply thresholds
    
    for T = [0.25 0.5 0.75]
        
        out_thresholded = image_threshold(out33,T);
        
        figure
        subplot(1,3,1)
        hold on
        imshow(grad_mag,[])
        title('Original Gradient Magnitude')
        hold off
        subplot(1,3,2)
        hold on
        imshow(out33,[]) % IMPORTANT: update based on selected NMS
        title('Non-Maxima Suppression with 3x3 Window') % IMPORTANT: update based on selected NMS
        hold off
        subplot(1,3,3)
        hold on
        imshow(out_thresholded,[])
        title(strcat('Thresholded Image', 32, '- T =', 32, num2str(T)))
        hold off
        sgtitle(strcat('Retinal Image - Healthy - Frame', 32, num2str(i_slice), 32, '- Kernel:', 32, filter_title))
        
        figure
        subplot(1,3,1)
        hold on
        imshow(grad_mag,[])
        title('Original Gradient Magnitude')
        xlim([800 1800])
        ylim([1500 2500])
        hold off
        subplot(1,3,2)
        hold on
        imshow(out33,[]) % IMPORTANT: update based on selected NMS
        title('Non-Maxima Suppression with 3x3 Window') % IMPORTANT: update based on selected NMS
        xlim([800 1800])
        ylim([1500 2500])
        hold off
        subplot(1,3,3)
        hold on
        imshow(out_thresholded,[])
        title(strcat('Thresholded Image', 32, '- T =', 32, num2str(T)))
        xlim([800 1800])
        ylim([1500 2500])
        hold off
        sgtitle(strcat('Retinal Image - Healthy - Frame', 32, num2str(i_slice), 32, '- Kernel:', 32, filter_title))
        
    end
    
    save_slice_loc = save_slice_loc + 1 ;
    
end