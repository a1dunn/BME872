close all
clear all
clc

%%%%%%%%%% LOADING IMAGES %%%%%%%%%%

%% Problem 1, a) Load Mammo Images and make histograms
%folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - LungCT\Lab1 - LungCT';
folder = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\Mammo1';
filename = 'mdb';
imageFormat = '.pgm';
fileNums = ['015'; '020'; '037'; '055'; '082'; '103'; '154'; '229'; '274'; '315'; '319'];
for i = 1:11
    [Mammo(:, :, i), info] = imageRead(folder, imageFormat, strcat(filename, fileNums(i, :)));
end

%% Problem 1 a) Open and form Histograms of original images
for i = 1:11
    %[bins, freq] = intensityHistogram(Mammo, i, 0, 0, 1);
    %plotHist(bins,freq, "P1 a): Mammogram and histogram: "+i, Mammo(:, :, i));
end

%% Problem 1 b): Constrast Stretching
for i = 1:11
    [bins1, freq1] = intensityHistogram(Mammo, i, 0, 0, 1);
    out_img2 = contrast_stretch(Mammo(:, :, i));
    [bins2, freq2] = intensityHistogram(out_img2, 1, 0, 0, 1);
    plotHist2(bins1, freq1, bins2, freq2, Mammo(:, :, i), out_img2, "P1 b): Contrast Stretching of Mammogram : "+i);
end
