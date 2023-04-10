function [bins, freq] =  intensityHistogram(img, slice, mode, norm, first_bin_remove) 
% mode 0 = slice, mode 1 = volume, 
% norm 0/1 = normalize the histogram between 0 and 1, false/true
% first_bin_remove 0 = use all bins, 1 will remove the first bin
% Mode 0 is single slice image histogram, uses input parameter slice to
% determine which slide to determine histogram for

[x, y, z] = size(img); % Size of the inputted image 

% Compute the maximum intensity in the image 
if mode == 0
    max_inten = max(max(max(img(:,:, slice))));
    min_inten = min(min(min(img(:,:, slice))));
else
    max_inten = max(max(max(img)));
    min_inten = min(min(min(img)));
end

% Remove the first bin if required based on first_bin_remove 
if first_bin_remove == 1
    bins = min_inten+1:max_inten+1;
    freq = zeros(1, max_inten-min_inten+1);
else
    bins = min_inten:max_inten+1;
    freq = zeros(1, max_inten-min_inten+2);
end

% Iterate through all pixels of the image and count the pixels that fall
% within each bin to yield freequency values per bin 
if mode == 0  
    for i = 1:x
        for j = 1:y
            intensity = img(i, j, slice);
            if (intensity == min_inten) && (first_bin_remove)
                %pass
            else
                freq(intensity-min_inten+1) = freq(intensity-min_inten+1) + 1;
            end
        end
    end
    % Mode 1 is volume image histogram, dopesnt use input parameter slice
elseif mode == 1
    for k = 1:z
        for i = 1:x
            for j = 1:y
                intensity = img(i, j, k);
                if (intensity == min_inten) && (first_bin_remove)
                    %pass
                else
                    freq(intensity-min_inten+1) = freq(intensity-min_inten+1) + 1;
                end
            end
        end
    end
end

% Only normalize in the argument norm says to
if norm
    freq = freq/max(freq);
end

end