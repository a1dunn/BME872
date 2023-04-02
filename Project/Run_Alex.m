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


%% Calculate Edge Quality

E = imageQuality_edge(CT_data, 'plot');
