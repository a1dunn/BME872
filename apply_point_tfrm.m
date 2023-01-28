function [out_img] = apply_point_tfrm(in_img, C, B)
    [x, y, z] = size(in_img);
    out_img = zeros(x, y, z);
    % convert the input image to 32-bit integers
    out_img = int32(out_img);
    for k = 1:z
        for i = 1:x
            for j = 1:y
                out_img(x, y, z) = in_img(x, y, z);
            end
        end
    end
    % apply the scaling and offset to each pixel
    out_img = in_img*C + B;
    for k = 1:z
        for i = 1:x
            for j = 1:y
                if out_img(x, y, z) > 255 
                    out_img(x, y, z) = 255;
                end
                if out_img(x, y, z) < 0
                    out_img(x, y, z) = 0;
                end
            end
        end
    end


    % convert the input image to 8-bit integers
    %out_img = im2uint8(out_img);
end
