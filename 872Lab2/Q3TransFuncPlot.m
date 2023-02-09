function [out_img] = Q3TransFuncPlot(A, B, I_min)

    figure
    plot([0,A],[I_min, I_min], 'LineWidth', 2, 'Color', 'r')
    hold on
    plot([A, A],[A, I_min], 'LineWidth', 2, 'Color', 'r')
    plot([A, B],[A, B], 'LineWidth', 2, 'Color', 'r')
    plot([B,B],[B, I_min], 'LineWidth', 2, 'Color', 'r')
    plot([B, 255], [I_min, I_min], 'LineWidth', 2, 'Color', 'r')

    title("P3: Transfer function for values A = "+A+" B = "+B+" I min = "+I_min)
    ylabel('Output Intensity')
    xlabel('Input Intensity')
    xlim([0 255])
    ylim([0 255])
    hold off
end