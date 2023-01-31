close all
clear all
clc

num_MRI_img = 20;

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
    
[volBrain(:,:,i_frames_brain_MRI), infoBrain(i_frames_brain_MRI)] = imageRead(folder, imageFormat, filename);
end

folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1';
filename = 'PNGTest';
imageFormat = '.png';

[img_png, info_png] = imageRead(folder, imageFormat, filename);
% folder = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\BrainMRI1';
% imageFormat = '.dcm';


%% Plot a single example of a lung CT image

figure
imshow(volCT.data(:,:,volCT.size(3)/2),[min(min(volCT.data(:,:,volCT.size(3)/2))) max(max(volCT.data(:,:,volCT.size(3)/2)))])
colorbar('eastoutside')
clear title
title('Lung CT - Slice 143')

%% Plot a single example of a brain MRI image

dimensions_brainMRI = size(volBrain);
brain_MRI_double  = cast(volBrain(:,:,dimensions_brainMRI(3)/2), "double");

% figure
% imshow(brain_MRI_double,[min(min(brain_MRI_double)) max(max(brain_MRI_double))])
% colorbar('eastoutside')
% clear title
% title('Brain MRI - Slice 10')

%% Plot all brain MRI slices in a single figure

% figure
% montage(volBrain, 'DisplayRange', [double(min(min(min(volBrain(:,:,:))))) double(max(max(max(volBrain(:,:,:)))))] )
% colorbar('eastoutside')
% clear title
% title('Brain MRI - All Slices')

% brain and lung signle slice with image
[bins, freq] = intensityHistogram(volBrain, dimensions_brainMRI(3)/2, 0, 0, 1);
plotHist(bins,freq, "2.2.1a: Brain 1 MRI Center Slice and Histogram", volBrain(:,:,dimensions_brainMRI(3)/2))
[bins, freq] = intensityHistogram(volCT.data, volCT.size(3)/2, 0, 0, 0);
plotHist(bins,freq, "2.2.1a: Lung CT Center Slice and Histogram", volCT.data(:,:,volCT.size(3)/2))

% brain and lung volume hist
[bins, freq] = intensityHistogram(volBrain, 0, 1, 0, 1);
plotHist(bins,freq, "2.2.1b: Brain 1 MRI Volume Histogram")
[bins, freq] = intensityHistogram(volCT.data, 0, 1, 0, 0);
plotHist(bins,freq, "2.2.1b: Lung CT Volume Histogram")

% brain and lung volume PDF
[bins, freq] = intensityHistogram(volBrain, 0, 1, 1, 1);
plotHist(bins,freq, "2.2.1c: Brain 1 MRI Volume PDF")
[bins, freq] = intensityHistogram(volCT.data, 0, 1, 1, 0);
plotHist(bins,freq, "2.2.1c: Lung CT Volume PDF")

%% Intensity, Scaling and Shifting

% Original image
C = 1;
B = 0;
out_img = apply_point_tfrm(volBrain(:,:,12), C, B);
[bins, freq] = intensityHistogram(out_img, 1, 0, 0, 1);
plotHist(bins,freq, "2.3.1a: Brain 1 MRI Slice 12, C = 1, B = 0", out_img)

% Scale and shift 1
C = 1.5;
B = 100;
out_img = apply_point_tfrm(volBrain(:,:,12), C, B);
[bins, freq] = intensityHistogram(out_img, 1, 0, 0, 1);
plotHist(bins,freq, "2.3.1a: Brain 1 MRI Slice 12, C = , B = ", out_img)
