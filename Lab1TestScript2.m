%% 2.3.1 Question 3a) Image Subtraction
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

%% 2.3.1 Question 3b) Image Subtraction

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

%% 2.3.1 Question 3c) Image Subtraction

filename ='noise_10x_post';
[volCT_noise, ~] = imageRead(folder, imageFormat, filename);
[out_img] = image_subtraction(volCT_noise.data,volCT_post.data);
[bins, freq] = intensityHistogram(out_img, 143, 0, 0, 0);
plotHist(bins,freq, "Lung CT Noise - Slice 143", out_img(:,:,143))
[bins, freq] = intensityHistogram(out_img, 80, 0, 0, 0);
plotHist(bins,freq, "Lung CT Noise - Slice 80", out_img(:,:,80))
[bins, freq] = intensityHistogram(out_img, 200, 0, 0, 0);
plotHist(bins,freq, "Lung CT Noise - Slice 200", out_img(:,:,200))