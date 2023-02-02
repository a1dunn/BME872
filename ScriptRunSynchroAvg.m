close all
clear all
clc
%% Intensity, Scaling and Shifting

    
img = load('C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\BrainMRI2\brainMRI_1.mat');
volBrain1 = img.vol;
img = load('C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\BrainMRI2\brainMRI_2.mat');
volBrain2 = img.vol;
img = load('C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\BrainMRI2\brainMRI_3.mat');
volBrain3 = img.vol;
img = load('C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\BrainMRI2\brainMRI_4.mat');
volBrain4 = img.vol;
img = load('C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\BrainMRI2\brainMRI_5.mat');
volBrain5 = img.vol;
img = load('C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\BrainMRI2\brainMRI_6.mat');
volBrain6 = img.vol;



out_img = average_images(volBrain1(:, :, 10:170));

%imshow(out_img, [min(min(out_img)) max(max(out_img))]) 
[bins, freq] = intensityHistogram(out_img, 1, 0, 0, 1);
plotHist(bins,freq, "2.3.1-4: Syncropnized Averaging", out_img)

