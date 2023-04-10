function [C] = imageQuality_contrast2(image, plot)
% Perform contrast equalization using the "histeq" function
equalized_image = histeq(image);

% Calculate the standard deviation of the pixel intensities in the original
% and equalized images
sigma_original = std(double(image(:)));
sigma_equalized = std(double(equalized_image(:)));
if (plot == 1)
    figure
    hold on
    
    % Show the equalized image
    subplot(2,2,3)
    imshow(equalized_image,[])
    title('Equalized Histogram Image')
    
    % Show the histogram of the equalized image
    subplot(2,2,4)
    histogram(equalized_image(:), 'HandleVisibility', 'off'); 
    hold on
    xlabel('Pixel Intensity')
    ylabel('Count')
    title('Equalized Image Histogram')
    
    % Plot the mean and standard deviation of the equalized image as vertical lines
    sigma_equalized = std(double(equalized_image(:)));
    mean_equalized = mean(double(equalized_image(:)));
    line([mean_equalized mean_equalized], ylim,'LineWidth', 1.5, 'Color', 'k', 'DisplayName', 'Mean')
    line([mean_equalized-sigma_equalized mean_equalized-sigma_equalized], ylim, 'LineStyle', '--','LineWidth', 1.5 ,'Color', [166 77 121]./255, 'HandleVisibility', 'off'); 
    line([mean_equalized+sigma_equalized mean_equalized+sigma_equalized], ylim, 'LineStyle', '--','LineWidth', 1.5, 'Color', [166 77 121]./255, 'DisplayName', 'Std Dev')
    legend('show')
    % Show the original image
    subplot(2,2,1)
    imshow(image,[])
    title('Original Image')
    
    % Show the histogram of the original image
    subplot(2,2,2)
    histogram(image(:), 'HandleVisibility', 'off'); 
    hold on
    xlabel('Pixel Intensity')
    ylabel('Count')
    title('Original Image Histogram')
    
    % Plot the mean and standard deviation of the original image as vertical lines
    sigma_original = std(double(image(:)));
    mean_original = mean(double(image(:)));
    line([mean_original mean_original], ylim,'LineWidth', 1.5, 'Color', 'k', 'DisplayName', 'Mean')
    line([mean_original-sigma_original mean_original-sigma_original], ylim, 'LineStyle', '--','LineWidth', 1.5, 'Color', [166 77 121]./255, 'HandleVisibility', 'off'); 
    line([mean_original+sigma_original mean_original+sigma_original], ylim, 'LineStyle', '--','LineWidth', 1.5, 'Color', [166 77 121]./255, 'DisplayName', 'Std Dev')
    legend('show')
    hold off
end

% Calculate the contrast improvement metric as the ratio of the standard
% deviation of the equalized image to the standard deviation of the
% original image
%C = sigma_equalized / sigma_original;

C = sigma_equalized / sigma_original;

end