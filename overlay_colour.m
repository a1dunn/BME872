function [out_img] = overlay_colour ( img , img_mask , colour, trans)
    [rows, cols, channels] = size(img);
    out_img = zeros(rows, cols, 3);
    out_img = out_img - min(min(img));
    colour_mask = zeros(rows, cols, 3);
    out_img(:, :, 1) = img;
    out_img(:, :, 2) = img;
    out_img(:, :, 3) = img;
    colour_mask(:, :, 1) = colour(1);
    colour_mask(:, :, 2) = colour(2);
    colour_mask(:, :, 3) = colour(3);
    for k = 1:channels
        for i = 1:rows
            for j = 1:cols
                if (img_mask(i, j, k) == 0)
                    colour_mask(i, j, 1) = 0;
                    colour_mask(i, j, 2) = 0;
                    colour_mask(i, j, 3) = 0;
                else
                    colour_mask(i, j, k) = colour_mask(i, j, k);
            end
        end
    end
   
    %img_mask = img_mask .* repmat(reshape(colour, [1, 1, 3]), [rows, cols, 1]);
    out_img = out_img + trans * colour_mask;
end