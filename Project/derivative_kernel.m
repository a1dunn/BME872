function [kernel, filter_title] = derivative_kernel(name, direction)
%DERIVATIVE_KERNEL Provides a filtering mask for the requested derivative
%filter
%   Inputs:
%       name: a string containing the name of the filtering operation to be performed
%               - 'central': central difference operation filter kernel
%               - 'forward': forward difference operation filter kernel
%               - 'prewitt': Prewitt filter kernel
%               - 'sobel': Sobel filter kernel
%       direction: a string containing the desired edge detection direction
%               - 'x': provide the filter kernel for detecting vertical edges
%               - 'y': provide the filter kernel for detecting vertical edges
%   Output:
%       kernel: requested derivative filter kernel
%       filter_title: name of the filter for figure title

% Provide the central difference kernel
if strcmp('central',name)
    filter_title = 'Central Difference';
    if strcmp(direction,'y') % Kernel for vertical edge detection
        kernel = [1 0 -1];
    elseif strcmp(direction,'x') % Kernel for horizontal edge detection
        kernel = [1 0 -1]';
    end
% Provide the forward difference kernel
elseif strcmp('forward',name)
    filter_title = 'Forward Difference';
    if strcmp(direction,'y') % Kernel for vertical edge detection
        kernel = [0 1 -1];
    elseif strcmp(direction,'x') % Kernel for horizontal edge detection
        kernel = [0 1 -1]';
    end
% Provide the Prewitt kernel
elseif strcmp('prewitt',name)
    filter_title = 'Prewitt';
    if strcmp(direction,'y') % Kernel for vertical edge detection
        kernel = [1 0 -1; 1 0 -1; 1 0 -1];
    elseif strcmp(direction,'x') % Kernel for horizontal edge detection
        kernel = [-1 -1 -1; 0 0 0; 1 1 1];
    end
% Provide the Sobel kernel
elseif strcmp('sobel',name)
    filter_title = 'Sobel';
    if strcmp(direction,'y') % Kernel for vertical edge detection
        kernel = [1 0 -1; 2 0 -2; 1 0 -1];
    elseif strcmp(direction,'x') % Kernel for horizontal edge detection
        kernel = [1 2 1; 0 0 0; -1 -2 -1];
    end
end

end

