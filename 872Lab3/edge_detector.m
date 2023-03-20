function edges = edge_detector(img , H, varargin)
%EDGE_DETECTOR Detect edges in an image
%   Inputs: 
%       img: image being processed (greyscale or RGB) 
%       H: filtering kernel (approximates horizontal derivative) 
%       T: [optional] threshold used by edge detector (default :0.1)
%       wndsz: [optional] size of NMS filter window (default :5) 

%   Outputs: 
%       edges: binary image where ’1’ indicates an image edge

img = im2double(img);

% if ‘img ’ is a colour image , convert it to greyscale first 
if size(img,3) > 1 
    img = rgb2gray(img);
end
% ‘nargin ’ returns number of input arguments (set defaults) 
if nargin == 2 
    T = 0.1; 
    wndsz = 5;
end

% TO DO - Fill in with your processing code



end


