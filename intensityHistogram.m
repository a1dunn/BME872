function [bins, freq] =  intensityHistogram(img, slice, mode, norm) % mode 0 = slice, mode 1 = volume, norm 0/1 = false/true
% Mode 0 is single slice image histogram, uses input parameter slice to
% determine which slide to determine histogram for

[x, y, z] = size(img);
freq = zeros(1, 256);
bins = 0:255;

if mode == 0
    for i = 1:x
        for j = 1:y
            intensity = img(i, j, slice);
            freq(intensity+1) = freq(intensity+1) + 1;
        end
    end
    % Mode 1 is volume image histogram, dopesnt use input parameter slice
elseif mode == 1
    for k = 1:z
        for i = 1:x
            for j = 1:y
                intensity = img(i, j, k);
                freq(intensity+1) = freq(intensity+1) + 1;
            end
        end
    end
end

% only normalize in the arguement says to
if norm
    freq = freq/max(freq);
end
end