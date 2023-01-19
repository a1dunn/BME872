function [] = plotHist(bins,freq, title_plot)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

figure 
hold on
bar(bins,freq, 'b')
title(title_plot)
ylabel('Number of Pixels')
xlabel('Intensity')
hold off

end

