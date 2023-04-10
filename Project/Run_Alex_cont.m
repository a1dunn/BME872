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

for i_frames_brain_MRI = 1:4
    filename = strcat(folder, '\brainMRI_', num2str(i_frames_brain_MRI), '.mat');
    img = load(filename);
    MRI_data(:, :, :, i_frames_brain_MRI) = img.vol;
end

[ct_row, ct_col, ct_sli] = size(double(CT_data(:, :, :, 1)));
[mr_row, mr_col, mr_sli] = size(double(MRI_data(:, :, :, 1)));

%% Calculate Edge Quality
% for CTfiles = [1 4]
%     for slice_num = 1:ct_sli
% 
%         
%         C_CT(CTfiles, slice_num) = imageQuality_contrast(CT_data(:, :, slice_num, CTfiles), -1200, 1200);
%         
%     end
% end

%%

% for MRfiles = 1:6
%     for slice_num = 1:mr_sli
% 
%         C_MR(MRfiles, slice_num) = imageQuality_contrast(MRI_data(:, :, slice_num, MRfiles), -100, 400);
% 
%     end
% end

% ground_truth_CT = [repmat(1,1,ct_sli); repmat(0.5,1,ct_sli); repmat(10,1,ct_sli); repmat(2,1,ct_sli)];
% % Display edge quality metric plot
% figure;
% hold on
% plot(ground_truth_CT(1, :),C_CT(1, :),'.', 'Color', [10 162 173]./255)
% %plot(ground_truth_CT(2, :),C_CT(2, :),'.', 'Color', [1 154 72]./255)
% %plot(ground_truth_CT(3, :),C_CT(3, :),'.', 'Color', [32 0 177]./255)
% plot(ground_truth_CT(4, :),C_CT(4, :),'.', 'Color', [206 13 103]./255)
% title('Edge Metric Versus Increasing Noise: Lung CT')
% xlabel('Noise Level')
% ylabel('Contrast Metric')
% legend('training post', 'noise 0.5x post', 'noise 10x post', 'training pre19mm')
% hold off
% 
% ground_truth_MR = [repmat(1,1,mr_sli); repmat(2,1,mr_sli); repmat(3,1,mr_sli); repmat(4,1,mr_sli); repmat(5,1,mr_sli); repmat(6,1,mr_sli)];
% % Display edge quality metric plot
% figure;
% hold on
% plot(ground_truth_MR(1, :),C_MR(1, :),'.', 'Color', [10 162 173]./255)
% plot(ground_truth_MR(2, :),C_MR(2, :),'.', 'Color', [1 154 72]./255)
% plot(ground_truth_MR(3, :),C_MR(3, :),'.', 'Color', [32 0 177]./255)
% plot(ground_truth_MR(4, :),C_MR(4, :),'.', 'Color', [206 13 103]./255)
% plot(ground_truth_MR(5, :),C_MR(5, :),'.', 'Color', [206 13 103]./255)
% plot(ground_truth_MR(6, :),C_MR(6, :),'.', 'Color', [206 13 103]./255)
% title('Edge Metric Versus Increasing Noise: Brain MRI 2')
% xlabel('Noise Level')
% ylabel('Contrast Metric')
% hold off
%%

for contrast_reduce = 1:4
    for slice_num = 1:ct_sli
        outImg = adjustIntensityRange(CT_data(:, :, slice_num, 1), contrast_reduce);
        disp = 0;
        if (slice_num == 143)
        disp = 1;
        end
        C_CT_Mod(contrast_reduce, slice_num) = imageQuality_contrast2(outImg, disp);

    end
end
C_CT_Mod(isinf(C_CT_Mod)) = 0;
hold off
ground_truth_CT = [repmat(1,1,ct_sli); repmat(2,1,ct_sli); repmat(3,1,ct_sli); repmat(4,1,ct_sli); repmat(5,1,ct_sli); repmat(6,1,ct_sli); repmat(7,1,ct_sli); repmat(8,1,ct_sli)];
figure;
hold on
plot(ground_truth_CT(1:4, 1),C_CT_Mod(1:4, 1),'.', 'Color', [83 183 170]./255, 'DisplayName', 'Per slice')
plot(ground_truth_CT(1:4, 2:end),C_CT_Mod(1:4, 2:end),'.', 'Color', [83 183 170]./255, 'HandleVisibility', 'off');

plot(1:4, C_CT_Mod(1:4, 143), 'o--', 'Color', [166 77 121]./255, 'MarkerFaceColor', [166 77 121]./255, 'DisplayName', 'Slice 143');
plot(1,nanmean(C_CT_Mod(1, :)),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'DisplayName', 'Per volume')
 for i = 2:4  
     plot(i,nanmean(C_CT_Mod(i, :)),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'HandleVisibility', 'off'); 
 end

legend('show')
title('Contrast Metric Versus Contrast Stretching: CT Training Post')
xlabel('Contrast Modification Level')
ylabel('Contrast Metric')
hold off

for contrast_reduce = 1:4
    for slice_num = 1:mr_sli
        outImg = adjustIntensityRange(MRI_data(:, :, slice_num, 4), contrast_reduce);
        disp = 0;
        if (slice_num == 90)
        disp = 1;
        end
        C_MR_Mod(contrast_reduce, slice_num) = imageQuality_contrast2(outImg, disp);
        
    end
end
C_MR_Mod(isinf(C_MR_Mod)) = 0;


ground_truth_MR = [repmat(1,1,mr_sli); repmat(2,1,mr_sli); repmat(3,1,mr_sli); repmat(4,1,mr_sli); repmat(5,1,mr_sli); repmat(6,1,mr_sli)];
figure;
hold on
plot(ground_truth_MR(1:4, 1),C_MR_Mod(1:4, 1),'.', 'Color', [83 183 170]./255, 'DisplayName', 'Per slice')
plot(ground_truth_MR(1:4, 2:end),C_MR_Mod(1:4, 2:mr_sli),'.', 'Color', [83 183 170]./255, 'HandleVisibility', 'off');

plot(1:4, C_MR_Mod(1:4, 90), 'o--', 'Color', [166 77 121]./255, 'MarkerFaceColor', [166 77 121]./255, 'DisplayName', 'Slice 90');
plot(1,nanmean(C_MR_Mod(1, :)),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'DisplayName', 'Per volume')
 for i = 2:4  
     plot(i,nanmean(C_MR_Mod(i, :)),'s', 'MarkerFaceColor', [61 133 198]./255, 'MarkerEdgeColor', [61 133 198]./255, 'HandleVisibility', 'off'); 
 end
legend('show')

title('Contrast Metric Versus Contrast Stretching: Brain MRI 2')
xlabel('Contrast Modification Level')
ylabel('Contrast Metric')
hold off