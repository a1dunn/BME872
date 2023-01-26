function [] = plotHist(bins,freq, title_plot, varargin)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if isempty(varargin) == 0
    figure
    hold on
    imshow(varargin{1,1},[min(min(varargin{1})) max(max(varargin{1}))])
    colorbar('eastoutside')
    hold off
else
    figure
    subplot(1,2,1)
    hold on
    bar(bins,freq,'b')
    title('Image')
    hold off
    subplot(1,2,2)
    hold on
    bar(bins,freq,'b')
    title('Intensity Histogram')
    ylabel('Intensity Histogram')
    xlabel('Intensity')
    hold off
    sgtitle(title_plot) 
end


end

