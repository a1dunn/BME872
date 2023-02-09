function [out_img] = contrast_piecewise(in_img,a, b)

%% Compute slope and y-intercept values for each segment of the piecewise linear function

slope_p1 = a(2)/a(1);
b_p1 = 0;
slope_p2 = (b(2)-a(2))/(b(1)-a(1));
b_p2 = b(2) - slope_p2*b(1);
slope_p3 = (255-b(2))/(255-b(1));
b_p3 = b(2) - slope_p3*b(1);

%% Plot the transfer function
figure
hold on
title(strcat('Piecewise linear function with a = [', num2str(a(1)),',',32,num2str(a(2)), 32, 'and b = [',num2str(b(1)),',',32,num2str(b(2)),']'))
ylabel('Output Intensity (s)')
xlabel('Input Intensity (r)')
% plot([0 a(1)], [0 a(2)], 'k')
% plot([a(1) b(1)], [a(2) b(2)], 'k')
% plot([b(1) 255], [b(2),255], 'k')
plot([0 a(1)], [0 slope_p1*a(1)+b_p1], 'b')
plot([a(1) b(1)], [slope_p2*a(1)+b_p2 slope_p2*b(1)+b_p2], 'b')
plot([b(1) 255], [slope_p2*b(1)+b_p2 255], 'b')
xlim([0,255]);
ylim([0,255]);
hold off

%% Apply the transfer function
[numrow, numcol] = size(in_img);
out_img = zeros(numrow,numcol);

for i_row = 1:numcol
    for j_col = 1:numrow
        if in_img(i_row,j_col) <= a(1)
            out_img(i_row,j_col) = slope_p1*in_img(i_row,j_col) + b_p1;
        elseif a(1) < in_img(i_row,j_col) <= b(1)
            out_img(i_row,j_col) = slope_p2*in_img(i_row,j_col) + b_p2;
        elseif in_img(i_row,j_col) <= 255
            out_img(i_row,j_col) = slope_p3*in_img(i_row,j_col) + b_p3;
        end
    end
end


end

