close all
clear all
clc
%folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - LungCT\Lab1 - LungCT';
folder = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\LungCT';
filename = 'training_post';
imageFormat = '.mhd';
[volCT, infoCT] = imageRead(folder, imageFormat, filename);
filename = 'training_mask';
imageFormat = '.mhd';
[volCTMask, infoCTMask] = imageRead(folder, imageFormat, filename);
[out_img] = apply_mask ( volCT.data , volCTMask.data );
for i = 100:50:200
figure
    i
    hold on
    subplot(1,3,1), imshow(volCT.data(:, :, i),[min(min(volCT.data(:, :, i))) max(max(volCT.data(:, :, i)))])
    colorbar('eastoutside')
    title('Original Image')
    hold off
    hold on
    subplot(1,3,2), imshow(volCTMask.data(:, :, i),[min(min(volCTMask.data(:, :, i))) max(max(volCTMask.data(:, :, i)))])
    colorbar('eastoutside')
    title('Mask')
    hold off
    hold on
    subplot(1,3,3), imshow(out_img(:, :, i),[min(min(out_img(:, :, i))) max(max(out_img(:, :, i)))])
    colorbar('eastoutside')
    title('Masked Image')
    hold off
    remaining = volCT.data(:, :, i) - out_img(:, :, i);
    [bins, freq] = intensityHistogram(volCT.data(:, :, i), 1, 0, 0, 0);
    plotHist(bins,freq, "2.3.1-2b): Original Lung CT Slice "+i, volCT.data(:, :, i))
    [bins, freq] = intensityHistogram(remaining, 1, 0, 0, 0);
    plotHist(bins,freq, "2.3.1-2b): Remaining Tissue Lung CT Slice "+i, remaining)
 
    [bins, freq] = intensityHistogram(out_img(:, :, i), 1, 0, 0, 0);
    plotHist(bins,freq, "2.3.1-2b): Masked Tissue Lung CT Slice "+i, out_img(:, :, i))

    colour_img = overlay_colour ( volCT.data(:, :, i) , volCTMask.data(:, :, i) ,[255,0,0], 0.50);
    figure
    imshow(colour_img, [min(min(varargin{1})) max(max(varargin{1}))])
end