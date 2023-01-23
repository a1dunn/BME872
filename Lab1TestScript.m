close all
clear all
clc

folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - LungCT\Lab1 - LungCT';
filename = 'training_post';
imageFormat = '.mhd';

[volCT, infoCT] = imageRead(folder, imageFormat, filename);

folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - BrainMRI1\Lab1 - BrainMRI1';
imageFormat = '.dcm';

for i_frames_brain_MRI = 1:20
    filename = 'brain_0';
    if i_frames_brain_MRI<10
        filename = strcat('brain_00', num2str(i_frames_brain_MRI));
    else 
        filename = strcat('brain_0', num2str(i_frames_brain_MRI));
    end
    
[volBrain(:,:,i_frames_brain_MRI), infoBrain] = imageRead(folder, imageFormat, filename);
end

folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1';
filename = 'PNGTest';
imageFormat = '.png';

[img_png, info_png] = imageRead(folder, imageFormat, filename);

freq = [1:10];
bins = [1:10];
title = 'plot';

% plotHist(bins,freq,title)

%% Plot a single example of a lung CT image

figure
imshow(volCT.data(:,:,volCT.size(3)/2),[min(min(volCT.data(:,:,volCT.size(3)/2))) max(max(volCT.data(:,:,volCT.size(3)/2)))])
colorbar('eastoutside')
clear title
title('Lung CT - Slice 143')

%% Plot a single example of a brain MRI image

dimensions_brainMRI = size(volBrain);
brain_MRI_double  = cast(volBrain(:,:,dimensions_brainMRI(3)/2), "double");

figure
imshow(brain_MRI_double,[min(min(brain_MRI_double)) max(max(brain_MRI_double))])
colorbar('eastoutside')
clear title
title('Brain MRI - Slice 10')

%% Plot all brain MRI slices in a single figure

figure
montage(volBrain, 'DisplayRange', [double(min(min(min(volBrain(:,:,:))))) double(max(max(max(volBrain(:,:,:)))))] )
colorbar('eastoutside')
clear title
title('Brain MRI - All Slices')