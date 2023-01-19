close all
clear all
clc

% folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - LungCT\Lab1 - LungCT';
% filename = 'noise_0.5x_post';
% imageFormat = '.mhd';

% folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - BrainMRI1\Lab1 - BrainMRI1';
% filename = 'brain_001';
% imageFormat = '.dcm';

folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1';
filename = 'PNGTest';
imageFormat = '.png';

[img, info] = imageRead(folder, imageFormat, filename);