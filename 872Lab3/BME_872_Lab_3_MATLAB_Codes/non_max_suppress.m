function out = non_max_suppress(img, H, W)

img_padded = padarray(abs(img), [floor(H/2), floor(W/2)], 'replicate');

[row, col] = size(img);
out = zeros(row, col);

for i = 1:row
    for j = 1:col
        
        window = img_padded(i, j:j+W-1);
        
        % check if the center pixel is a local maximum
        center = window(floor(W/2)+1);
        if center == max(window(:))
            out(i,j) = center;
        end
    end
end

for i = 1:row
    for j = 1:col
        
        window = img_padded(i:i+H-1, j);
        
        % check if the center pixel is a local maximum
        center = window(floor(H/2)+1);
        if center == max(window(:))
            out(i,j) = out(i,j) + center;
        end
    end
end


end


