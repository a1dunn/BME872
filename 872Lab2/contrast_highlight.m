function [out_img] = contrast_highlight (img, A, B, I_min)
[x, y, z] = size(img);
out_img = img;
for i = 1:x
    for j = 1:y
        intensity = img(i, j);
        if (intensity < A)
            out_img(i, j) = I_min;
        end
        if (intensity > B)
            out_img(i, j) = I_min;
            
        end
    end
end
end
