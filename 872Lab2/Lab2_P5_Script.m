close all
clear all
clc

%%%%%%%%%% LOADING IMAGES %%%%%%%%%%

%% Problem 1, a) Load Mammo Images and make histograms
%folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - LungCT\Lab1 - LungCT';
folder = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\Mammo1';
filename = 'mdb';
imageFormat = '.pgm';
fileNums = ['015'; '020'; '154'; ];
for i = 1:3
    [Mammo(:, :, i), info] = imageRead(folder, imageFormat, strcat(filename, fileNums(i, :)));
end

%% Problem 3 Contrast Highlighting
for i = 1:3
    [bins1, freq1] = intensityHistogram(Mammo, i, 0, 0, 1);
    out_img = histogram_equalization(Mammo(:, :, i));
    [bins2, freq2] = intensityHistogram(out_img, 1, 0, 0, 1);
    plotHist2(bins1, freq1, bins2, freq2, Mammo(:, :, i), out_img, "P5: Histogram Equalization : "+i);
end
