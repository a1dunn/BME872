function [img,info] = imageRead(path, imageFormat, filename)
% Open files
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
elseif strcmp(imageFormat, '.pgm')
    cd(path)
    filename_load = strcat(filename, imageFormat);
    info = NaN;
    [img] = imread(filename_load);
end

end

