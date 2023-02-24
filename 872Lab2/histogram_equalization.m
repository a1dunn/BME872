function [out_img] = histogram_equalization (img)
[bins, freq] = intensityHistogram(img, 1, 1, false, true);
% calculate the cumulative distribution function of the histogram
cdf = zeros(size(freq));
cdf(1) = freq(1);
for i = 2:length(freq)
    cdf(i) = cdf(i-1) + freq(i);
end

% normalize the cdf to the range [0, 1]
cdf = cdf / numel(img);

% Apply the transformation function to compute the equalized image
out_img = uint8(255 * cdf(double(img) + 1));

end