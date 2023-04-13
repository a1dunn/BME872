%% Medical Image Loading
clear all
close all
clc

folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - LungCT\Lab1 - LungCT'; % Folder where iamges are located - user dependent
filename = {'training_post', 'noise_0.5x_post', 'noise_10x_post', 'training_pre19mm'}; % Names of CT datasets
imageFormat = '.mhd';
% Iterate through all four CT datasets and load the associated files
for filevairations = 1:4
    [volCT, infoCT] = imageRead(folder, imageFormat, char(filename(filevairations)));
    CT_data(:, :, filevairations) = volCT;
end

folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - BrainMRI2\Lab1 - BrainMRI2'; % Folder where iamges are located - user dependent
% Iterate through all MRI volumes and load the associated files
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

[bins,freq] = intensityHistogram(CT_data(:, :, 4).data, 143, 0, 1, 0); % Generate frequency and bin vectors for the intensity histogram
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

[ct_row, ct_col, ct_sli] = size(double(CT_data(:, :, 1).data)); % Compute the number of rows, columns, and slices in each CT image volume file

% Loop through all CT images and compute the N metric using the three
% different methods
loop_index = 1;
loop_index_plot_per_slice = 1;
for CTfiles = 1:4
    for slice_num = 1:ct_sli
        slice_num
        % Plot the figures showing the full analysis pipeline for slice 143
        % of the post_contrast CT images
        if slice_num == 143 && CTfiles == 1
            plot_fig = 1;
        else
            plot_fig = 0;
        end
        N1(loop_index) = imageQuality_noise(double(CT_data(:, :, CTfiles).data(:,:,slice_num)), 1,0,plot_fig);
        N2(loop_index) = imageQuality_noise(double(CT_data(:, :, CTfiles).data(:,:,slice_num)), 2,0,plot_fig);
        N3(loop_index) = imageQuality_noise(double(CT_data(:, :, CTfiles).data(:,:,slice_num)), 3,0,plot_fig);
        if slice_num == 143
            N_CT(loop_index_plot_per_slice) = N2(loop_index);
            loop_index_plot_per_slice = loop_index_plot_per_slice + 1;
        end
        loop_index = loop_index +1;
    end
end

N_CT_plot = [N_CT(2) N_CT(1) N_CT(3)];
noise_ground_truth = [repmat(1,1,ct_sli) repmat(0.5,1,ct_sli) repmat(10,1,ct_sli) repmat(1,1,ct_sli)];
N_CT_avg = [nanmean(N2(287:572)) nanmean([N2(1:286) N2(859:1144)]) nanmean(N2(573:858))];

%% Plot the calculated noise metrics against the added noise level - CT images

x_axis_CT = [0.5 1 10]; % X-axis vector for plotting
figure
hold on
plot(noise_ground_truth(1),N2(1),'.', 'Color', [83 183 170]./255, 'DisplayName', 'Per slice')
plot(noise_ground_truth,N2,'.', 'Color', [83 183 170]./255, 'HandleVisibility', 'off');
plot([0.5 1 10], N_CT_plot(1:3), 'o--', 'Color', [166 77 121]./255, 'MarkerFaceColor', [166 77 121]./255, 'DisplayName', 'Slice 143');
plot(0.5,N_CT_avg(1),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'DisplayName', 'Per volume')
for i = 2:3
    plot(x_axis_CT(i),N_CT_avg(i),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'HandleVisibility', 'off');
end
legend('show')
title('Noise Metric Versus Increasing Noise: Lung CT')
xlabel('Noise Level')
ylabel('Noise Metric')
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

[mri_row, mri_col, mri_sli] = size(double(MRI_data(1,1,1).vol)); % Compute the number of rows, columns, and slices in each MRI image volume file

% Loop through all CT images and compute the N metric using the three
% different methods
loop_index = 1;
loop_index_plot_per_slice = 1;
for MRIfiles = 1:6
    for slice_num = 1:mri_sli
        % Plot the figures showing the full analysis pipeline for slice 90
        % of the noise level 1 MRI images
        if slice_num == 90 && MRIfiles == 2
            plot_fig = 1;
        else
            plot_fig = 0;
        end
        N1_MRI(loop_index) = imageQuality_noise(double(MRI_data(1,1,MRIfiles).vol(:,:,slice_num)), 3,1,plot_fig);
        N2_MRI(loop_index) = imageQuality_noise(double(MRI_data(1,1,MRIfiles).vol(:,:,slice_num)), 2,1,plot_fig);
        N3_MRI(loop_index) = imageQuality_noise(double(MRI_data(1,1,MRIfiles).vol(:,:,slice_num)), 2,1,plot_fig);
        if slice_num == 110
            N_MR(loop_index_plot_per_slice) = N2_MRI(loop_index);
            loop_index_plot_per_slice = loop_index_plot_per_slice + 1;
        end
        loop_index = loop_index +1;
    end
end

noise_ground_truth_MRI = [repmat(1,1,mri_sli) repmat(2,1,mri_sli) repmat(3,1,mri_sli) repmat(4,1,mri_sli) repmat(5,1,mri_sli) repmat(6,1,mri_sli)];
N2_MRI(N2_MRI==0) = NaN;
N_MR_avg = [nanmean(N2_MRI(1:181)) nanmean(N2_MRI(182:362)) nanmean(N2_MRI(363:543)) nanmean(N2_MRI(544:724)) nanmean(N2_MRI(725:905)) nanmean(N2_MRI(906:1086))];

%% Plot the calculated noise metrics against the added noise level - MRI images

figure
hold on
plot(noise_ground_truth_MRI(1),N2_MRI(1),'.', 'Color', [83 183 170]./255, 'DisplayName', 'Per slice')
plot(noise_ground_truth_MRI,N2_MRI,'.', 'Color', [83 183 170]./255, 'HandleVisibility', 'off');
plot(1:6, N_MR(1:6), 'o--', 'Color', [166 77 121]./255, 'MarkerFaceColor', [166 77 121]./255, 'DisplayName', 'Slice 100');
plot(1,N_MR_avg(1),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'DisplayName', 'Per volume')
for i = 2:6
    plot(i,N_MR_avg(i),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'HandleVisibility', 'off');
end
legend('show')
title('Noise Metric Versus Increasing Noise: Brain MRI 2')
xlabel('Noise Level')
ylabel('Noise Metric')
hold off