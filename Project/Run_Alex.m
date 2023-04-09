%% Medical Image Loading
clear all 
close all
folder = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\LungCT';
filename = {'training_post', 'noise_0.5x_post', 'noise_10x_post', 'training_pre19mm'};
imageFormat = '.mhd';
for filevairations = 1:4
    [volCT, infoCT] = imageRead(folder, imageFormat, char(filename(filevairations)));
    CT_data(:, :, :, filevairations) = volCT.data;
end

folder = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\BrainMRI2';

for i_frames_brain_MRI = 1:6
    filename = strcat(folder, '\brainMRI_', num2str(i_frames_brain_MRI), '.mat');
    img = load(filename);
    MRI_data(:, :, :, i_frames_brain_MRI) = img.vol;
end

[ct_row, ct_col, ct_sli] = size(double(CT_data(:, :, :, 1)));
[mr_row, mr_col, mr_sli] = size(double(MRI_data(:, :, :, 1)));

%% Calculate Edge Quality
for CTfiles = 1:4
    for slice_num = 1:ct_sli
      
        E_CT(CTfiles, slice_num) = imageQuality_edge(CT_data(:, :, slice_num, CTfiles),2, 10);
        
    end
end
%%
for MRfiles = 1:6
    for slice_num = 1:mr_sli
        E_MR(MRfiles, slice_num) = imageQuality_edge(MRI_data(:, :, slice_num, MRfiles), 2, 10);
        
    end
end

ground_truth_CT = [repmat(1,1,ct_sli); repmat(0.5,1,ct_sli); repmat(10,1,ct_sli); repmat(1,1,ct_sli)];
% Display edge quality metric plot
figure;
hold on
plot(ground_truth_CT(1, :),E_CT(1, :),'.', 'Color', [10 162 173]./255)
plot(ground_truth_CT(2, :),E_CT(2, :),'.', 'Color', [1 154 72]./255)
plot(ground_truth_CT(3, :),E_CT(3, :),'.', 'Color', [32 0 177]./255)
plot(ground_truth_CT(4, :),E_CT(4, :),'.', 'Color', [206 13 103]./255)
title('Edge Metric Versus Increasing Noise: Lung CT')
xlabel('Noise Level')
ylabel('Edge Metric')
legend('training post', 'noise 0.5x post', 'noise 10x post', 'training pre19mm')
hold off

ground_truth_MR = [repmat(1,1,mr_sli); repmat(2,1,mr_sli); repmat(3,1,mr_sli); repmat(4,1,mr_sli); repmat(5,1,mr_sli); repmat(6,1,mr_sli)];
% Display edge quality metric plot
figure;
hold on
plot(ground_truth_MR(1, :),E_MR(1, :),'.', 'Color', [10 162 173]./255)
plot(ground_truth_MR(2, :),E_MR(2, :),'.', 'Color', [10 162 173]./255)
plot(ground_truth_MR(3, :),E_MR(3, :),'.', 'Color', [10 162 173]./255)
plot(ground_truth_MR(4, :),E_MR(4, :),'.', 'Color', [10 162 173]./255)
plot(ground_truth_MR(5, :),E_MR(5, :),'.', 'Color', [10 162 173]./255)
plot(ground_truth_MR(6, :),E_MR(6, :),'.', 'Color', [10 162 173]./255)
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
    for slice_num = 1:2:ct_sli
        E_MA_CT(kernal_size, slice_num) = imageQuality_edge(imfilter(CT_data(:, :, slice_num, 1), kernel, 'replicate'), 2, 10);
        plot((kernal_size),E_MA_CT(kernal_size, slice_num), '.', 'Color', [10 162 173]./255)
    end
end
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
    for slice_num = 1:2:mr_sli
        E_MA_MR(kernal_size, slice_num) = imageQuality_edge(imfilter(MRI_data(:, :, slice_num, 1), kernel, 'replicate'), 2, 10);
        plot((kernal_size),E_MA_MR(kernal_size, slice_num), '.', 'Color', [10 162 173]./255)
    end

end
xlabel('Kernal Size (NxN)')
ylabel('Edge Metric')
title('Edge Metric Versus Moving Average Kernal Size: Brain MRI 2')
hold off