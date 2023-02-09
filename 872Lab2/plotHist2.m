function [] = plotHist2(bins1, freq1, bins2, freq2, img1, img2, title_plot)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    figure
    hold on
    subplot(2,2,1), imshow(img1,[0 255])
    colorbar('eastoutside')
    title('Original Image')
    hold off
    subplot(2,2,2)
    hold on
    bar(bins1,freq1,'b')
    title('Original Intensity Histogram')
    ylabel('Frequency')
    xlabel('Intensity')
    xlim([0 255])
    subplot(2,2,3), imshow(img2,[0 255])
    colorbar('eastoutside')
    title('Constrast Stretched Image')
    hold off
    subplot(2,2,4)
    hold on
    bar(bins2,freq2,'b')
    title('Contrast Stretched Intensity Histogram')
    ylabel('Frequency')
    xlabel('Intensity')
    xlim([0 255])
    hold off
    sgtitle(title_plot) 
    set(gcf, 'Position', [100, 100, 1100, 600])

end

