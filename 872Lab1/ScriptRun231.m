%% Intensity, Scaling and Shifting

%folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - LungCT\Lab1 - LungCT';
folder = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\LungCT';
filename = 'training_post';
imageFormat = '.mhd';

[volCT, infoCT] = imageRead(folder, imageFormat, filename);

%folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - BrainMRI1\Lab1 - BrainMRI1';
folder = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\BrainMRI1';
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
plotHist(bins,freq, "2.3.1a: Brain 1 MRI Slice 12, C = 1.5, B = 100", out_img)

% Scale and shift 2
C = 1;
B = 200;
out_img = apply_point_tfrm(volBrain(:,:,12), C, B);
[bins, freq] = intensityHistogram(out_img, 1, 0, 0, 1);
plotHist(bins,freq, "2.3.1a: Brain 1 MRI Slice 12, C = 1, B = 200", out_img)

%% Image Masking and Overlays

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

    colour_img = overlay_colour ( volCT.data(:, :, i) , volCTMask.data(:, :, i) ,[255,0,0], 0.5);
    figure
    hold on
    imshow(colour_img) 
    title("2.3.1-2c): Coloured Transparency Overlay on Lung CT Slice "+i)
    hold off
end