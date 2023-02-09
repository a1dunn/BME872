%%%%%%%% LAB 2 PROBLEM 2 %%%%%%%%

%% Set the a and b vectors

a = [125, 175];
b = [200, 230];

%% Pre-allocate space

[numrow, numcol, numslice] = size(Mammo);
out_img = zeros(numrow,numcol,numslice);

%% Problem 1 b): Constrast Stretching
for i_slice = 1:3
    [bins1, freq1] = intensityHistogram(Mammo(:,:,i_slice), 1, 0, 0, 1);
    img_out(:,:,i_slice) = contrast_piecewise(Mammo(:,:,i_slice), a, b);
    [bins2, freq2] = intensityHistogram(img_out(:,:,i_slice), 1, 0, 0, 1);
    plotHist2(bins1, freq1, bins2, freq2, Mammo(:, :, i_slice), img_out(:,:,i_slice), "P2: Piecewise Linear Contrast Adjusment of a Mammogram: "+i_slice);
end