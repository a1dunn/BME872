%% Synchronized averaging

folder_name = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\BrainMRI2\';
folder_name = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - BrainMRI2\Lab1 - BrainMRI2\';
filename = strcat(folder_name, 'brainMRI_1.mat');
img = load(filename);
volBrain1 = img.vol;
filename = strcat(folder_name, 'brainMRI_2.mat');
img = load(filename);
volBrain2 = img.vol;
filename = strcat(folder_name, 'brainMRI_3.mat');
img = load(filename);
volBrain3 = img.vol;
filename = strcat(folder_name, 'brainMRI_4.mat');
img = load(filename);
volBrain4 = img.vol;
filename = strcat(folder_name, 'brainMRI_5.mat');
img = load(filename);
volBrain5 = img.vol;
filename = strcat(folder_name, 'brainMRI_6.mat');
img = load(filename);
volBrain6 = img.vol;

out_img = average_images(volBrain1(:, :, 10:170));

%imshow(out_img, [min(min(out_img)) max(max(out_img))]) 
[bins, freq] = intensityHistogram(out_img, 1, 0, 0, 1);
plotHist(bins,freq, "2.3.1-4: Syncropnized Averaging", out_img)