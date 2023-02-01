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

imshow(img)

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