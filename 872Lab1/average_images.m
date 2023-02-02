function [out_img] = average_images(varargin)
    num = nargin;
    [x, y, z] = size(varargin{1});
    
    out_img = zeros(x, y);
    img = varargin{1,1};
    % Loop over all input images
    for i = 1:z
        
        out_img = out_img + img(:, :, i);
    end

    out_img = out_img / num;
end