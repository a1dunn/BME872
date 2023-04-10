%% Medical Image Loading
clear all
close all
clc

folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - LungCT\Lab1 - LungCT';
filename = {'training_post', 'noise_0.5x_post', 'noise_10x_post', 'training_pre19mm'};
imageFormat = '.mhd';
for filevairations = 1:4
    [volCT, infoCT] = imageRead(folder, imageFormat, char(filename(filevairations)));
    CT_data(:, :, filevairations) = volCT;
end

folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - BrainMRI2\Lab1 - BrainMRI2';

for i_frames_brain_MRI = 1:6
    filename = strcat(folder, '\brainMRI_', num2str(i_frames_brain_MRI), '.mat');
    img = load(filename);
    MRI_data(:, :, i_frames_brain_MRI) = img;
end

%% Plot Original CT Images and Normalized Intensity Histograms 

figure
hold on
imshow(CT_data(:, :, 4).data(:,:,143),[])
title('1x Noise - Pre-Contrast')
hold off

figure
hold on
title('1x Noise - Post-Contrast')
ax = gca;
hold off

figure
hold on
imshow(CT_data(:, :, 2).data(:,:,143),[])
title('0.5x Noise')
hold off

figure
hold on
imshow(CT_data(:, :, 3).data(:,:,143),[])
title('10x Noise')
hold off

[bins,freq] = intensityHistogram(CT_data(:, :, 4).data, 143, 0, 1, 0);
figure
hold on
bar(bins,freq,'FaceColor', [83 183 170]./255)
title('1x Noise - Pre-Contrast')
ylabel('Normalized Frequency')
xlabel('Intensity')
hold off

[bins,freq] = intensityHistogram(CT_data(:, :, 1).data, 143, 0, 1, 0);
figure
hold on
bar(bins,freq,'FaceColor', [83 183 170]./255)
title('1x Noise - Post-Contrast')
ylabel('Normalized Frequency')
xlabel('Intensity')
hold off

[bins,freq] = intensityHistogram(CT_data(:, :, 2).data, 143, 0, 1, 0);
figure
hold on
bar(bins,freq,'FaceColor', [83 183 170]./255)
title('0.5x Noise')
ylabel('Normalized Frequency')
xlabel('Intensity')
hold off

[bins,freq] = intensityHistogram(CT_data(:, :, 3).data, 143, 0, 1, 0);
figure
hold on
bar(bins,freq,'FaceColor', [83 183 170]./255)
title('10x Noise')
ylabel('Normalized Frequency')
xlabel('Intensity')
hold off

%% Noise quantification - CT

[ct_row, ct_col, ct_sli] = size(double(CT_data(:, :, 1).data));

loop_index = 1;
for CTfiles = 1:4
    for slice_num = 1:ct_sli
        slice_num
        if slice_num == 143 && CTfiles == 1
            plot_fig = 1;
        else
            plot_fig = 0;
        end
    N1(loop_index) = imageQuality_noise(double(CT_data(:, :, CTfiles).data(:,:,slice_num)), 1,0,plot_fig);
    N2(loop_index) = imageQuality_noise(double(CT_data(:, :, CTfiles).data(:,:,slice_num)), 2,0,plot_fig);
    N3(loop_index) = imageQuality_noise(double(CT_data(:, :, CTfiles).data(:,:,slice_num)), 3,0,plot_fig);
    loop_index = loop_index +1;
    end
end

noise_ground_truth = [repmat(1,1,ct_sli) repmat(0.5,1,ct_sli) repmat(10,1,ct_sli) repmat(1,1,ct_sli)];

% Plot the calculated noise metrics against the added noise level - CT images
figure 
hold on
plot(noise_ground_truth(1:286),N1(1:286),'.', 'Color', [10 162 173]./255)
plot(noise_ground_truth(286:572),N1(286:572),'.', 'Color', [1 154 72]./255)
plot(noise_ground_truth(572:858),N1(572:858),'.', 'Color', [32 0 177]./255)
plot(noise_ground_truth(858:1144),N1(858:1144),'.', 'Color', [206 13 103]./255)
title('Noise Metric Versus Ground Truth')
ylabel('Ground Truth Noise')
xlabel('Noise Metric')
legend('training post', 'noise 0.5x post', 'noise 10x post', 'training pre19mm')
hold off

figure 
hold on
plot(noise_ground_truth(1:286),N2(1:286),'.', 'Color', [10 162 173]./255)
plot(noise_ground_truth(287:572),N2(287:572),'.', 'Color', [1 154 72]./255)
plot(noise_ground_truth(573:858),N2(573:858),'.', 'Color', [32 0 177]./255)
plot(noise_ground_truth(859:1144),N2(859:1144),'.','Color',  [206 13 103]./255)
title('Noise Metric Versus Ground Truth')
ylabel('Ground Truth Noise')
xlabel('Noise Metric')
legend('training post', 'noise 0.5x post', 'noise 10x post', 'training pre19mm')
hold off

figure 
hold on
plot(noise_ground_truth(1:286),N3(1:286),'.', 'Color', [10 162 173]./255)
plot(noise_ground_truth(287:572),N3(287:572),'.', 'Color', [1 154 72]./255)
plot(noise_ground_truth(573:858),N3(573:858),'.', 'Color', [32 0 177]./255)
plot(noise_ground_truth(859:1144),N3(859:1144),'.', 'Color', [206 13 103]./255)
title('Noise Metric Versus Ground Truth')
xlabel('Ground Truth Noise')
ylabel('Noise Metric')
legend('training post', 'noise 0.5x post', 'noise 10x post', 'training pre19mm')
hold off

%% Plot Original CT Images and Normalized Intensity Histograms 

figure
hold on
imshow(MRI_data(1,1,1).vol(:,:,90),[])
title('Noise Level 1')
hold off

figure
hold on
imshow(MRI_data(1,1,2).vol(:,:,90),[])
title('Noise Level 2')
hold off

figure
hold on
imshow(MRI_data(1,1,3).vol(:,:,90),[])
title('Noise Level 3')
hold off

figure
hold on
imshow(MRI_data(1,1,4).vol(:,:,90),[])
title('Noise Level 4')
hold off

figure
hold on
imshow(MRI_data(1,1,5).vol(:,:,90),[])
title('Noise Level 5')
hold off

figure
hold on
imshow(MRI_data(1,1,6).vol(:,:,90),[])
title('Noise Level 6')
hold off

[bins,freq] = intensityHistogram(MRI_data(1,1,1).vol(:,:,:), 90, 0, 1, 1);
figure
hold on
bar(bins,freq,'FaceColor', [83 183 170]./255)
title('Noise Level 1')
ylabel('Normalized Frequency')
xlabel('Intensity')
hold off

[bins,freq] = intensityHistogram(MRI_data(1,1,2).vol(:,:,:), 90, 0, 1, 1);
figure
hold on
bar(bins,freq,'FaceColor', [83 183 170]./255)
title('Noise Level 2')
ylabel('Normalized Frequency')
xlabel('Intensity')
hold off

[bins,freq] = intensityHistogram(MRI_data(1,1,3).vol(:,:,:), 90, 0, 1, 1);
figure
hold on
bar(bins,freq,'FaceColor', [83 183 170]./255)
title('Noise Level 3')
ylabel('Normalized Frequency')
xlabel('Intensity')
hold off

[bins,freq] = intensityHistogram(MRI_data(1,1,4).vol(:,:,:), 90, 0, 1, 1);
figure
hold on
bar(bins,freq,'FaceColor', [83 183 170]./255)
title('Noise Level 4')
ylabel('Normalized Frequency')
xlabel('Intensity')
hold off

[bins,freq] = intensityHistogram(MRI_data(1,1,5).vol(:,:,:), 90, 0, 1, 1);
figure
hold on
bar(bins,freq,'FaceColor', [83 183 170]./255)
title('Noise Level 5')
ylabel('Normalized Frequency')
xlabel('Intensity')
hold off

[bins,freq] = intensityHistogram(MRI_data(1,1,6).vol(:,:,:), 90, 0, 1, 1);
figure
hold on
bar(bins,freq,'FaceColor', [83 183 170]./255)
title('Noise Level 6')
ylabel('Normalized Frequency')
xlabel('Intensity')
hold off


%% Noise quantification - MRI 

[mri_row, mri_col, mri_sli] = size(double(MRI_data(1,1,1).vol));

loop_index = 1;
for MRIfiles = 1:6
    for slice_num = 1:mri_sli
    N1_MRI(loop_index) = imageQuality_noise(double(MRI_data(1,1,MRIfiles).vol(:,:,slice_num)), 3,1);
    N2_MRI(loop_index) = imageQuality_noise(double(MRI_data(1,1,MRIfiles).vol(:,:,slice_num)), 2,1);
    N3_MRI(loop_index) = imageQuality_noise(double(MRI_data(1,1,MRIfiles).vol(:,:,slice_num)), 2,1);
    loop_index = loop_index +1;
    end
end

noise_ground_truth_MRI = [repmat(1,1,mri_sli) repmat(2,1,mri_sli) repmat(3,1,mri_sli) repmat(4,1,mri_sli) repmat(5,1,mri_sli) repmat(6,1,mri_sli)];

%% Plot the calculated noise metrics against the added noise level - MRI images
figure 
hold on
plot(noise_ground_truth_MRI,N1_MRI,'.')
title('Noise Metric Versus MRI File Number')
xlabel('MRI File Number')
ylabel('Noise Metric')
hold off

figure 
hold on
plot(noise_ground_truth_MRI,N2_MRI,'.')
title('Noise Metric Versus MRI File Number')
xlabel('MRI File Number')
ylabel('Noise Metric')
hold off

figure 
hold on
title('Noise Metric Versus MRI File Number')
plot(noise_ground_truth_MRI,N3_MRI,'.')
xlabel('MRI File Number')
ylabel('Noise Metric')
hold off