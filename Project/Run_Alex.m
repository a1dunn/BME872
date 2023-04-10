% Clear all variables and close all figures
clear all 
close all

% Set the folder and file names for the lung CT images
folder = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\LungCT';
filename = {'training_post', 'noise_0.5x_post', 'noise_10x_post', 'training_pre19mm'};
imageFormat = '.mhd';

% Load the lung CT images into a 4D array called CT_data
for filevairations = 1:4 % 4 file types
    [volCT, infoCT] = imageRead(folder, imageFormat, char(filename(filevairations)));
    CT_data(:, :, :, filevairations) = volCT.data;
end

% Set the folder and file names for the brain MRI images
folder = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\BrainMRI2';

% Load the brain MRI images into a 4D array called MRI_data
for i_frames_brain_MRI = 1:6 % 6 file variations
    filename = strcat(folder, '\brainMRI_', num2str(i_frames_brain_MRI), '.mat');
    img = load(filename);
    MRI_data(:, :, :, i_frames_brain_MRI) = img.vol;
end

% Get the dimensions of the lung CT and brain MRI images
[ct_row, ct_col, ct_sli] = size(double(CT_data(:, :, :, 1)));
[mr_row, mr_col, mr_sli] = size(double(MRI_data(:, :, :, 1)));

%% Calculate Edge Quality

% Loop through each CT file and slice number to calculate edge quality
for CTfiles = 1:4
    for slice_num = 1:ct_sli
        flag = 0;
        % Set flag to 1 if slice_num equals 143 and CTfiles equals 1
        if (slice_num == 143 && CTfiles == 1)
            flag = 1;
        end
        % Call imageQuality_edge function and store the result in E_CT
        E_CT(CTfiles, slice_num) = imageQuality_edge(CT_data(:, :, slice_num, CTfiles),2, 10, flag);
    end
end

% Loop through each MR file and slice number to calculate edge quality
for MRfiles = 1:6
    % Initialize mean_E_MR to 0 for each MR file
    mean_E_MR(MRfiles) = 0;
    for slice_num = 1:mr_sli
        flag = 0;
        % Set flag to 1 if slice_num equals 90 and MRfiles equals 1
        if (slice_num == 90 && MRfiles == 1)
            flag = 1;
        end
        % Call imageQuality_edge function and store the result in E_MR
        E_MR(MRfiles, slice_num) = imageQuality_edge(MRI_data(:, :, slice_num, MRfiles), 2, 10, flag);
        % If the result is greater than 0, add it to the mean_E_MR
        if (E_MR(MRfiles, slice_num) > 0)
            mean_E_MR(MRfiles) = mean_E_MR(MRfiles) + E_MR(MRfiles, slice_num);
        end
    end
    % Calculate the mean_E_MR for each MR file
    mean_E_MR(MRfiles) = mean_E_MR(MRfiles)/mr_sli;
end

%% Plot CT and MRI Noise results

% Define ground truth values for CT and MRI slices
ground_truth_CT = [repmat(1,1,ct_sli); repmat(0.5,1,ct_sli); repmat(10,1,ct_sli); repmat(1,1,ct_sli)];
ground_truth_MR = [repmat(1,1,mr_sli); repmat(2,1,mr_sli); repmat(3,1,mr_sli); repmat(4,1,mr_sli); repmat(5,1,mr_sli); repmat(6,1,mr_sli)];

% Display edge quality metric plot for CT slices
figure;
hold on
% Plot edge metric for each slice with respect to ground truth
plot(ground_truth_CT(1:4, 1),E_CT(1:4, 1),'.', 'Color', [83 183 170]./255, 'DisplayName', 'Per slice')
% Plot remaining edge metrics without displaying legend entry
plot(ground_truth_CT(1:4, 2:end),E_CT(1:4, 2:end),'.', 'Color', [83 183 170]./255, 'HandleVisibility', 'off');
% Plot edge metric for slice 143 with respect to noise level
temp(2) = E_CT(1, 143);
temp(1) = E_CT(2, 143);
temp(3) = E_CT(3, 143);
plot([0.5 1 10], temp(1:3), 'o--', 'Color', [166 77 121]./255, 'MarkerFaceColor', [166 77 121]./255, 'DisplayName', 'Slice 143');
% Plot mean edge metric for each volume
plot(1,mean([nanmean(E_CT(1, :)), nanmean(E_CT(1, :))]),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'DisplayName', 'Per volume')
% Plot mean edge metric for slices 2 to 3 without displaying legend entry
nums = [0 0.5 10];
for i = 2:3
    plot(nums(i),nanmean(E_CT(i, :)),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'HandleVisibility', 'off');
end
% Add title, axis labels and legend
title('Edge Metric Versus Increasing Noise: Lung CT')
xlabel('Noise Level')
ylabel('Edge Metric')
legend('show')
hold off

% Display edge quality metric plot
figure;
hold on
plot(ground_truth_MR(1:6, 1),E_MR(1:6, 1),'.', 'Color', [83 183 170]./255, 'DisplayName', 'Per slice')
plot(ground_truth_MR(1:6, 2:end),E_MR(1:6, 2:end),'.', 'Color', [83 183 170]./255, 'HandleVisibility', 'off');


plot(1:6, E_MR(1:6, 90), 'o--', 'Color', [166 77 121]./255, 'MarkerFaceColor', [166 77 121]./255, 'DisplayName', 'Slice 90');
plot(1,nanmean(E_MR(1, :)),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'DisplayName', 'Per volume')
for i = 2:6
    
    plot(i,nanmean(E_MR(i, :)),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'HandleVisibility', 'off');

end
legend('show')
title('Edge Metric Versus Increasing Noise: Brain MRI 2')
xlabel('Noise Level')
ylabel('Edge Metric')
hold off


%% Edge quality versus MA
figure;
hold on
for kernal_size = 3:2:30
    % Moving average to fill vessels
    kernel_size = [kernal_size, kernal_size];
    kernel = ones(kernel_size) / prod(kernel_size);
    for slice_num = 1:ct_sli
        E_MA_CT(kernal_size, slice_num) = imageQuality_edge(imfilter(CT_data(:, :, slice_num, 1), kernel, 'replicate'), 2, 10, 0);
        if(slice_num == 1 && kernal_size == 3)
            plot((kernal_size),E_MA_CT(kernal_size, slice_num), '.', 'Color', [83 183 170]./255, 'DisplayName', 'Per slice')
        end
        if(slice_num ~= 1 || kernal_size ~= 3)
            plot((kernal_size),E_MA_CT(kernal_size, slice_num), '.', 'Color', [83 183 170]./255, 'HandleVisibility', 'off');
        end
    end
end

plot(3:2:30, E_MA_CT(3:2:30, 143), 'o--', 'Color', [166 77 121]./255, 'MarkerFaceColor', [166 77 121]./255, 'DisplayName', 'Slice 143');
plot(3,nanmean(E_MA_CT(3, :)),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'DisplayName', 'Per volume')
for i = 5:2:30
    
    plot(i,nanmean(E_MA_CT(i, :)),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'HandleVisibility', 'off');

end
legend('show')
xlabel('Kernal Size (NxN)')
ylabel('Edge Metric')
title('Edge Metric Versus Moving Average Kernal Size: Lung CT Training Post')
hold off

%% Edge quality versus MA
figure;
hold on
for kernal_size = 3:2:30
    % Moving average to fill vessels
    kernel_size = [kernal_size, kernal_size];
    kernel = ones(kernel_size) / prod(kernel_size);
    for slice_num = 1:mr_sli
        E_MA_MR(kernal_size, slice_num) = imageQuality_edge(imfilter(MRI_data(:, :, slice_num, 1), kernel, 'replicate'), 2, 10, 0);
        if(slice_num == 1 && kernal_size == 3)
            plot((kernal_size),E_MA_MR(kernal_size, slice_num), '.', 'Color', [83 183 170]./255, 'DisplayName', 'Per slice')
        end
        if(slice_num ~= 1 || kernal_size ~= 3)
        plot((kernal_size),E_MA_MR(kernal_size, slice_num), '.', 'Color', [83 183 170]./255, 'HandleVisibility', 'off');
        end
    end

end

plot(3:2:30, E_MA_MR(3:2:30, 90), 'o--', 'Color', [166 77 121]./255, 'MarkerFaceColor', [166 77 121]./255, 'DisplayName', 'Slice 90');
plot(3,nanmean(E_MA_MR(3, :)),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'DisplayName', 'Per volume')
for i = 5:2:30
    
    plot(i,nanmean(E_MA_MR(i, :)),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'HandleVisibility', 'off');

end
legend('show')
xlabel('Kernal Size (NxN)')
ylabel('Edge Metric')
title('Edge Metric Versus Moving Average Kernal Size: Brain MRI 2')
hold off