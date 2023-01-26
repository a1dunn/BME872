function [bins, freq] =  intensityHistogram(img, slice, mode, norm, first_bin_remove) 
% mode 0 = slice, mode 1 = volume, 
% norm 0/1 = false/true
% first_bin_remove 0 = use all bins, 1 will remove first bin
% Mode 0 is single slice image histogram, uses input parameter slice to
% determine which slide to determine histogram for

[x, y, z] = size(img);
max_inten = max(max(max(img)));
min_inten = min(min(min(img)));

if first_bin_remove == 1
    bins = min_inten+1:max_inten;
    freq = zeros(1, max_inten-min_inten);
else
    bins = min_inten:max_inten;
    freq = zeros(1, max_inten-min_inten+1);
end
if mode == 0
    for i = 1:x
        for j = 1:y
            intensity = img(i, j, slice);
            if (intensity == min_inten) && (first_bin_remove)
                %pass
            else
                freq(intensity+1-min_inten+1) = freq(intensity+1-min_inten+1) + 1;
            end
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