function [img,info] = imageRead(path, imageFormat, filename)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Attach the appropriate extension based on the inputted image format and
% load the file with the provided filename 
if strcmp(imageFormat, '.mhd') % Load .mhd image
    filename_load = strcat(path, '\', filename, imageFormat);
    [img, info]=read_mhd(filename_load);
elseif strcmp(imageFormat, '.dcm') % Load .dcm image
    cd(path)
    filename_load = strcat(filename, imageFormat);
    [img] = dicomread(filename_load);  
    [info] = dicominfo(filename_load);  
elseif strcmp(imageFormat, '.png') % Load .png image
    filename_load = strcat(filename, imageFormat);
    info = NaN;
    [img] = imread(filename_load);
end

end

