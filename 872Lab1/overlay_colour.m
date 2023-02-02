function [out_img] = overlay_colour ( img , img_mask , colour, trans)
    [rows, cols, channels] = size(img);
    img = img - min(min(min(img)));
    img_uint16 = uint16(65536*mat2gray(img));
    img_mask_uint16 = uint16(img_mask);

    % convert the input image to 32-bit integers
    img_uint16 = repmat(img_uint16, [1, 1, 3]);
    img_mask_uint16 = repmat(img_mask_uint16, [1, 1, 3]);
    for i = 1:3
        img_mask_uint16(:, :, i) = img_mask_uint16(:, :, i) * colour(i);
    end
    out_img = img_uint16 + trans * img_mask_uint16;
    out_img = im2uint8(out_img);
end