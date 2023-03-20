%%% BME 872 LAB 1 PROBLEM 2.1 %%%

clear all
close all
clc

%% Load all images, convert them to grayscale, and save them into three arrays (one per dataset)

filepathroot = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 3';
filepaths = {'\diabetic_retinopathy', '\glaucoma', '\healthy'};
fileabreviations = {'dr', 'g', 'h'};

for dataset = 3
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

%% Plot images to verify correct loading

% for i_slice = 1:15
%     figure
%     hold on
%     title(strcat('DB - Frame', 32, num2str(i_slice)))
%     imshow(img_dr(:,:,i_slice),[])
%     hold off
% end
%
% for i_slice = 1:15
%     figure
%     hold on
%     title(strcat('G - Frame', 32, num2str(i_slice)))
%     imshow(img_g(:,:,i_slice),[])
%     hold off
% end
%
% for i_slice= 1:15
%     figure
%     hold on
%     title(strcat('H - Frame', 32, num2str(i_slice)))
%     imshow(img_h(:,:,i_slice),[])
%     hold off
% end


%% Apply a smoothing filter to select images

h = [1 4 7 4 1; 4 20 33 20 4; 7 33 55 33 7; 4 20 33 20 4; 1 4 7 4 1];

save_slice_loc = 1;
for i_slice = [5 10 15]
    img_h_s(:,:,save_slice_loc) = (1/331).*spatial_filter(img_h(:,:,i_slice),h);
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
    imshow(img_h_s(:,:,save_slice_loc),[])
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
    imshow(img_h_s(:,:,save_slice_loc),[])
    hold off
    
    save_slice_loc = save_slice_loc + 1 ;
end

%% Apply derivative filters to select images

filter_names = {'central' 'forward' 'prewitt' 'sobel'};
save_slice_loc = 15;
for i_slice = [5]
    
    for filter_num = 1:4
        
        [kernel, ~] = derivative_kernel(filter_names{filter_num}, 'x');
        grad_x = spatial_filter(img_h_s(:,:,save_slice_loc),kernel);
        [kernel, filter_title] = derivative_kernel(filter_names{filter_num}, 'y');
        grad_y = spatial_filter(img_h_s(:,:,save_slice_loc),kernel);
        grad_mag = (grad_y.^2 + grad_x.^2).^(1/2);
        
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
    end
    save_slice_loc = save_slice_loc + 1 ;
    
end