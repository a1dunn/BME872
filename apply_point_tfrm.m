function [out_img] = apply_point_tfrm(in_img, C, B)
    [x, y, z] = size(in_img);
    % convert the input image to 32-bit integers
    img_uint32 = uint32(in_img);

    
    % apply the scaling and offset to each pixel
    out_img = img_uint32.*C + B;
    out_img = out_img - min(min(min(out_img)));

    out_img = uint8(255*out_img/max(max(max(out_img))));
end
