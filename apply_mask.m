function [out_img] = apply_mask ( img , img_mask )
    %out_img = img.*img_mask;
    [x, y, z] = size(img);
    for k = 1:z
        for i = 1:x
            for j = 1:y
                if (img_mask(i, j, k) == 0)
                    out_img(i, j, k) = 0;
                else
                    out_img(i, j, k) = img(i, j, k);
            end
        end
    end

end