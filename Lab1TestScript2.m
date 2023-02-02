sliceLungCT= volCT.data(:,:,volCT.size(3)/2);

% [bins, freq] = intensityHistogram(volBrain, 10, 0, 0, 0)
% plotHist(bins,freq, 'Brain', volBrain(:,:,10))

% img = volBrain;
% filename = 'brain';
% path = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\writeImageTest';
% info = infoBrain;
% imageWrite(path, '.dcm', img, filename, info)
% 
% for i_frames_brain_MRI = 1:20
%     if i_frames_brain_MRI<10
%         filename = strcat('brain_00', num2str(i_frames_brain_MRI));
%     else
%         filename = strcat('brain_0', num2str(i_frames_brain_MRI));
%     end
%     
%     [volBrainread(:,:,i_frames_brain_MRI), infoBrainRead(i_frames_brain_MRI)] = imageRead(path, '.dcm', filename);
% end

% if min(min(min(volBrainread == volBrain)))
%     disp('.dcm files were saved successfully with no information loss')
%     dimensions_brainMRI = size(volBrain);
%     
%     brain_MRI_double  = cast(volBrain(:,:,dimensions_brainMRI(3)/2), "double");
%     brain_MRI_double_read  = cast(volBrainread(:,:,dimensions_brainMRI(3)/2), "double");
%     %
    %     figure
    %     subplot(1,2,1)
    %     hold on
    %     imshow(brain_MRI_double,[min(min(brain_MRI_double)) max(max(brain_MRI_double))])
    %     colorbar('eastoutside')
    %     title('Original Brain MRI - Slice 10')
    %     hold off
    %     subplot(1,2,2)
    %     hold on
    %     imshow(brain_MRI_double,[min(min(brain_MRI_double)) max(max(brain_MRI_double))])
    %     colorbar('eastoutside')
    %     title('Saved and Reread Brain MRI - Slice 10')
    %     hold off
    %
% end

path = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - LungCT\Lab1 - LungCT';
imageWrite(path, '.png', sliceLungCT, 'imgCT PNG')
[imgCT_PNG, info] = imageRead(path, '.png', 'imgCT PNG');

figure
subplot(1,2,1)
hold on
imshow(volCT.data(:,:,volCT.size(3)/2),[min(min(volCT.data(:,:,volCT.size(3)/2))) max(max(volCT.data(:,:,volCT.size(3)/2)))])
colorbar('eastoutside')
clear title
title('Original Lung CT - Slice 143')
hold off
subplot(1,2,2)
hold on
imshow(imgCT_PNG,[min(min(imgCT_PNG)) max(max(imgCT_PNG))])
colorbar('eastoutside')
title('Saved as PNG and Reread Lung CT - Slice 143')
hold off

x = [1 2 3 4; 5 6 7 8; 9 10 11 12; 13 14 15 16];
x_uint8 = uint8(x)
b = uint16(20.*ones(4,4));
x_uint16 = uint16(x_uint8);

y = 20.*x_uint16 + b

%% 2.3.1 QUESTION 3
folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - LungCT\Lab1 - LungCT';
imageFormat = '.mhd';
filename ='training_post';
[volCT_post, ~] = imageRead(folder, imageFormat, filename);
filename = 'training_pre19mm';
[volCT_pre, ~] = imageRead(folder, imageFormat, filename);

[out_img] = image_subtraction(volCT_post.data, volCT_pre.data);
[out_img] = image_subtraction(volCT_post.data, volCT_pre.data);

figure
subplot(1,3,1)
hold on
imshow(volCT_pre.data(:,:,volCT_pre.size(3)/2),[min(min(volCT_pre.data(:,:,volCT_pre.size(3)/2))) max(max(volCT_pre.data(:,:,volCT_pre.size(3)/2)))])
colorbar('eastoutside')
clear title
title('Pre-Contrast Lung CT - Slice 143')
hold off
subplot(1,3,2)
hold on
imshow(volCT_post.data(:,:,volCT_post.size(3)/2),[min(min(volCT_post.data(:,:,volCT_post.size(3)/2))) max(max(volCT_post.data(:,:,volCT_post.size(3)/2)))])
colorbar('eastoutside')
title('Post-Contrast Lung CT - Slice 143')
hold off
subplot(1,3,3)
hold on
imshow(out_img(:,:,143),[min(min(volCT_post.data(:,:,volCT_post.size(3)/2))) max(max(volCT_post.data(:,:,volCT_post.size(3)/2)))])
colorbar('eastoutside')
title('Subtracted (Perfusion) Lung CT - Slice 143')
hold off

slice = 80;
figure
subplot(1,3,1)
hold on
imshow(volCT_pre.data(:,:,slice),[min(min(volCT_pre.data(:,:,slice))) max(max(volCT_pre.data(:,:,slice)))])
colorbar('eastoutside')
clear title
title('Pre-Contrast Lung CT - Slice 80')
hold off
subplot(1,3,2)
hold on
imshow(volCT_post.data(:,:,slice),[min(min(volCT_post.data(:,:,slice))) max(max(volCT_post.data(:,:,slice)))])
colorbar('eastoutside')
title('Post-Contrast Lung CT - Slice 80')
hold off
subplot(1,3,3)
hold on
imshow(out_img(:,:,slice),[min(min(volCT_post.data(:,:,slice))) max(max(volCT_post.data(:,:,slice)))])
colorbar('eastoutside')
title('Subtracted (Perfusion) Lung CT - Slice 80')
hold off

slice = 200;
figure
subplot(1,3,1)
hold on
imshow(volCT_pre.data(:,:,slice),[min(min(volCT_pre.data(:,:,slice))) max(max(volCT_pre.data(:,:,slice)))])
colorbar('eastoutside')
clear title
title('Pre-Contrast Lung CT - Slice 200')
hold off
subplot(1,3,2)
hold on
imshow(volCT_post.data(:,:,slice),[min(min(volCT_post.data(:,:,slice))) max(max(volCT_post.data(:,:,slice)))])
colorbar('eastoutside')
title('Post-Contrast Lung CT - Slice 200')
hold off
subplot(1,3,3)
hold on
imshow(out_img(:,:,slice),[min(min(volCT_post.data(:,:,slice))) max(max(volCT_post.data(:,:,slice)))])
colorbar('eastoutside')
title('Subtracted (Perfusion) Lung CT - Slice 200')
hold off


%% Image Subtraction 3b)

folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - LungCT\Lab1 - LungCT';
imageFormat = '.mhd';
filename ='training_mask';
[volCT_mask, ~] = imageRead(folder, imageFormat, filename);
inv_mask_HU_scale = -min(min(min(volCT_post.data))).*(~volCT_mask.data);
inv_mask_HU_scale(inv_mask_HU_scale == 0) = 1;
perfusion_mask = apply_mask(out_img,volCT_mask.data);
perfusion_masked_image = image_subtraction(perfusion_masked,inv_mask_HU_scale);
transparency_mask = volCT_mask.data;
transparency_mask(transparency_mask == 0) = [];

for i_slice = [80 143 200]
    figure
    sgtitle(strcat('Lung CT - Slice', 32, num2str(i_slice)))
    subplot(2,2,1)
    hold on
    imshow(volCT_pre.data(:,:,i_slice),[min(min(volCT_pre.data(:,:,i_slice))) max(max(volCT_pre.data(:,:,i_slice)))])
    colorbar('eastoutside')
    clear title
    title('Pre-Contrast Image')
    hold off
    subplot(2,2,2)
    hold on
    imshow(volCT_post.data(:,:,i_slice),[min(min(volCT_post.data(:,:,i_slice))) max(max(volCT_post.data(:,:,i_slice)))])
    colorbar('eastoutside')
    title('Post-Contrast Image')
    hold off
    subplot(2,2,3)
    hold on
    imshow(perfusion_masked(:,:,i_slice),[min(min(volCT_post.data(:,:,i_slice))) max(max(volCT_post.data(:,:,i_slice)))])
    colorbar('eastoutside')
    title('Masked Perfusion Intensity Image')
    hold off
    subplot(2,2,4)
    hold on
    imshow(volCT_pre.data(:,:,i_slice),[min(min(volCT_pre.data(:,:,i_slice))) max(max(volCT_pre.data(:,:,i_slice)))])
    colorbar('eastoutside')
    imshow(perfusion_mask(:,:,i_slice),[min(min(volCT_pre.data(:,:,i_slice))) max(max(volCT_pre.data(:,:,i_slice)))])
    %image(perfusion_mask(:,:,i_slice),[min(min(volCT_pre.data(:,:,i_slice))) max(max(volCT_pre.data(:,:,i_slice)))]); %, 'AlphaData', transparency_mask(:,:,i_slice))
    % imshow(perfusion_overlay(:,:,i_slice),[min(min(volCT_post.data(:,:,i_slice))) max(max(volCT_post.data(:,:,i_slice)))])
    % colorbar('eastoutside')
    title('Perfusion Image with Overlay')
    hold off
end



%% 10x

filename ='noise_10x_post';
[volCT_noise, ~] = imageRead(folder, imageFormat, filename);
[out_img] = image_subtraction(volCT_noise.data,volCT_post.data);
[bins, freq] = intensityHistogram(out_img, 143, 0, 0, 0);
plotHist(bins,freq, "Lung CT Noise - Slice 143", out_img(:,:,143))
[bins, freq] = intensityHistogram(out_img, 80, 0, 0, 0);
plotHist(bins,freq, "Lung CT Noise - Slice 80", out_img(:,:,80))
[bins, freq] = intensityHistogram(out_img, 200, 0, 0, 0);
plotHist(bins,freq, "Lung CT Noise - Slice 200", out_img(:,:,200))
