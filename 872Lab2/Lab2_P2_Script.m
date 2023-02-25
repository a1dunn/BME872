%%%%%%%% LAB 2 PROBLEM 2 %%%%%%%%
close all
% folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 2\Mammo1';
% %folder = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\Mammo1';
% filename = 'mdb';
% imageFormat = '.pgm';
% fileNums = ['015'; '020'; '154'; ];
% for i = 1:3
%     [Mammo(:, :, i), info] = imageRead(folder, imageFormat, strcat(filename, fileNums(i, :)));
% end

%% Set the a and b vectors
a = [125, 7; 129, 28; 80, 12];
b = [230, 255; 240, 255; 184, 255];

%% Pre-allocate space

[numrow, numcol, numslice] = size(Mammo);
out_img = zeros(numrow,numcol,numslice);

%% Problem 1 b): Constrast Stretching
for i_slice = 1:3
    [bins1, freq1] = intensityHistogram(Mammo(:,:,i_slice), 1, 0, 0, 1);
    img_out(:,:,i_slice) = contrast_piecewise(Mammo(:,:,i_slice), a(i_slice,:), b(i_slice,:));
    [bins2, freq2] = intensityHistogram(img_out(:,:,i_slice), 1, 0, 0, 1);
    plotHist2(bins1, freq1, bins2, freq2, Mammo(:, :, i_slice), img_out(:,:,i_slice), "P2: Piecewise Linear Contrast Adjusment of a Mammogram: "+i_slice);
end