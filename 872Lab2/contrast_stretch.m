function [out_img] = contrast_stretch(in_img)
    % convert the input image to 32-bit integers
    out_img = double(in_img);

    max_inten = max(max(max(out_img)));
    min_inten = min(min(min(out_img)));

    % apply the stretching
    out_img = uint8(255*((out_img/(max_inten-min_inten))-(min_inten/(max_inten-min_inten))));
end