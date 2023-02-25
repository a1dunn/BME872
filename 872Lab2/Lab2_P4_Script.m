%%%%%%%% LAB 2 PROBLEM 4 %%%%%%%%
close all
% folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 2\Mammo1';
% %folder = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\Mammo1';
% filename = 'mdb';
% imageFormat = '.pgm';
% fileNums = ['015'; '020'; '154'; ];
% for i = 1:3
%     [Mammo(:, :, i), info] = imageRead(folder, imageFormat, strcat(filename, fileNums(i, :)));
% end

Tr = zeros(256,1);

a = [125, 7; 129, 28; 80, 12];
b = [230, 255; 240, 255; 184, 255];

for i_slice = 1:3
    [coeffs, ~] = polyfit([0, a(i_slice,1)], [0, a(i_slice,2)],1);
    slope_p1 = coeffs(1);
    b_p1 = coeffs(2);
    [coeffs, ~] = polyfit([a(i_slice,1), b(i_slice,1)], [a(i_slice,2), b(i_slice,2)],1);
    slope_p2 = coeffs(1);
    b_p2 = coeffs(2);
    [coeffs, ~] = polyfit([b(i_slice,1), 255], [b(i_slice,2), 255],1);
    slope_p3 = coeffs(1);
    b_p3 = coeffs(2);
    
    for i_intensity = 0:255
        if i_intensity <= a(i_slice,1)
            Tr(i_intensity+1) = slope_p1*i_intensity + b_p1;
        elseif a(i_slice,1) < i_intensity && i_intensity <= b(i_slice,1)
            Tr(i_intensity+1) = slope_p2*i_intensity + b_p2;
        else 
            Tr(i_intensity+1) = slope_p3*i_intensity + b_p3;
        end
    end
    
    figure
    hold on
    title(strcat('Piecewise linear function with a = [', num2str(a(i_slice,1)),',',32,num2str(a(i_slice,2)), 32, '] and b = [',num2str(b(i_slice,1)),',',32,num2str(b(i_slice,2)),']'))
    plot(Tr)
    ylabel('Output Intensity (s)')
    xlabel('Input Intensity (r)')
    hold off
    
   [bins1, freq1] = intensityHistogram(Mammo(:,:,i_slice), 1, 0, 0, 1);
   [out_img] = contrast_tfrm_curve(Mammo(:,:,i_slice), Tr);
   [bins2, freq2] = intensityHistogram(img_out(:,:,i_slice), 1, 0, 0, 1);
   plotHist2(bins1, freq1, bins2, freq2, Mammo(:, :, i_slice), img_out(:,:,i_slice), "P2: Piecewise Linear Contrast Adjusment of a Mammogram: "+i_slice);
    
end