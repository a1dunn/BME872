function out = non_max_suppress(img, H, W)

img_padded = padarray(img, [floor(H/2), floor(W/2)], 'replicate');

[row, col] = size(img);
out = zeros(row, col);

for i = 1:row
    for j = 1:col
        
        window = img_padded(i:i+H-1, j:j+W-1);
        
        % check if the center pixel is a local maximum
        center = window(floor(H/2)+1, floor(W/2)+1);
        if center == max(window(:))
            out(i,j) = center;
        end
    end
end
end