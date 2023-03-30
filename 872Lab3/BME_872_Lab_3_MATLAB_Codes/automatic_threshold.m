function [T] = automatic_threshold(gm)

gm(gm == 0) = NaN;

img_median = 3.5*median(gm,'all','omitnan');
img_mean = mean(gm,'all','omitnan');
img_percent = prctile(gm,97,'all');
T = img_median;

end

