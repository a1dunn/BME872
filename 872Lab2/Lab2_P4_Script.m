%% PROBLEM 4

Tr = zeros(256,1);

for i_slice = 1:3
    
    rmax = double(max(max(Mammo(:,:,i_slice))));
    rmin = double(min(min(Mammo(:,:,i_slice))));
    
    for i_intensity = 0:255
        Tr(i_intensity+1) = 255*((1/(rmax-rmin))*i_intensity-(rmin/(rmax-rmin)));
    end
    [bins1, freq1] = intensityHistogram(Mammo(:,:,i_slice), 1, 0, 0, 1);
    img_out(:,:,i_slice) = contrast_tfrm_curve(Mammo(:,:,i_slice), Tr);
    [bins2, freq2] = intensityHistogram(img_out(:,:,i_slice), 1, 0, 0, 1);
    plotHist2(bins1, freq1, bins2, freq2, Mammo(:, :, i_slice), img_out(:,:,i_slice), "P4: LUT-Based Contrast Stretching of a Mammogram: "+i_slice);
       
end