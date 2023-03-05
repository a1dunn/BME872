function [out_img] = contrast_tfrm_curve(img, T)

[numrow, numcol] = size(img);
out_img = zeros(numrow,numcol);
img = double(img);

for i_row = 1:numcol
    for j_col = 1:numrow
        out_img(i_row,j_col) = T(img(i_row,j_col)+1);
    end
end
    
out_img = uint8(out_img); 
    
end

