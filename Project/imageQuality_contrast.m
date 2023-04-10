function [C] = imageQuality_contrast(img, img_min, img_max)

img = img - img_min;
img = uint8(256*img/img_max);
% Calculate histogram

[bins, freq] = intensityHistogram(img, 1, 0, 0, 0, 0, 256) ;
%plotHist(bins,freq, "Test")


cdf = zeros(size(freq));
cdf(1) = freq(1);
for i = 2:length(freq)
    cdf(i) = cdf(i-1) + freq(i);
end

% normalize the cdf to the range [0, 1]
cdf = cdf / max(cdf);

plot(cdf)
% Calculate spreadness of cdf
mu = mean(cdf);
sigma = std(cdf);
spreadness = abs(mu - 0.5) / sigma;

% Convert spreadness to score (higher is better)
C = 1 / (1 + spreadness);
end

%% Compare Hist Eq to original