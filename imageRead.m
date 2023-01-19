function [img,info] = imageRead(path, imageFormat, filename)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if strcmp(imageFormat, '.mhd')
    filename_load = strcat(path, '\', filename, imageFormat);
    [img, info]=read_mhd(filename_load);
elseif strcmp(imageFormat, '.dcm')
    cd(path)
    filename_load = strcat(filename, imageFormat);
    [img] = dicomread(filename_load);  
    [info] = dicominfo(filename_load);  
elseif strcmp(imageFormat, '.png')
    filename_load = strcat(filename, imageFormat);
    info = NaN;
    [img] = imread(filename_load);
end

end

