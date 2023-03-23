function [T] = automatic_threshold(gm)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

img_median = median(gm,'all');
T = 0.8*img_median;

end

