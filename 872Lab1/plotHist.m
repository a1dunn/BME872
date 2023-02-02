function [] = plotHist(bins,freq, title_plot, varargin)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if isempty(varargin) == 0
    figure
    hold on
    subplot(1,2,1), imshow(varargin{1,1},[min(min(varargin{1})) max(max(varargin{1}))])
    colorbar('eastoutside')
    title('Image')
    hold off
    subplot(1,2,2)
    hold on
    bar(bins,freq,'b')
    title('Intensity Histogram')
    ylabel('Frequency')
    xlabel('Intensity')
    hold off
    sgtitle(title_plot) 
    set(gcf, 'Position', [100, 100, 1100, 600])
else
    figure
    hold on
    bar(bins,freq,'b')
    title(title_plot)
    ylabel('Frequency')
    xlabel('Intensity')
    hold off
end


end

