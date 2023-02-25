close all
clear all
clc

%%%%%%%%%% LOADING IMAGES %%%%%%%%%%

%% Problem 1, a) Load Mammo Images and make histograms
%folder = 'C:\Users\cassi\OneDrive\Documents\BME 872\Labs\Lab 1\Lab1 - LungCT\Lab1 - LungCT';
folder = 'C:\Users\DunnA\Documents\YEAR4\BME872\872Labz\Mammo1';
filename = 'mdb';
imageFormat = '.pgm';
fileNums = ['015'; '020'; '154'; ];
for i = 1:3
    [Mammo(:, :, i), info] = imageRead(folder, imageFormat, strcat(filename, fileNums(i, :)));
end

square_size = 100;


%% Problem 6
for k = 1:3
    [rows, cols, ~] = size(Mammo(:, :, k));
    num_rows = ceil(rows / square_size);
    num_cols = ceil(cols / square_size);
    output_img = uint8(zeros(rows, cols));
    for i = 1:num_rows
        for j = 1:num_cols
            % Compute square bounds
            row_start = (i - 1) * square_size + 1;
            row_end = min(row_start + square_size - 1, rows);
            col_start = (j - 1) * square_size + 1;
            col_end = min(col_start + square_size - 1, cols);

            square = Mammo(row_start:row_end, col_start:col_end, k);
            square = histogram_equalization(square);

            output_img(row_start:row_end, col_start:col_end, :) = square;
        end
    end

    [bins1, freq1] = intensityHistogram(Mammo, k, 0, 0, 1);
    
    [bins2, freq2] = intensityHistogram(output_img, 1, 0, 0, 1);
    plotHist2(bins1, freq1, bins2, freq2, Mammo(:, :, k), output_img, "P5: Histogram Equalization : "+k);
    
end
