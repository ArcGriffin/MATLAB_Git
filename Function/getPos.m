function [x,y,z] = getPos(A,xy_ratio,z_max,varargin)
%GETPOS Summary of this function goes here
%   Detailed explanation goes here

if length(varargin) == 1
    if strcmp(varargin{1},'flip')
        A = flip(A,1);
        A = flip(A,2);
    end
elseif length(varargin) >= 1
    error('Error. Invalid number of input arguments.')
end

if ndims(A) == 2
    [x,y,z] = twodim(A,xy_ratio,z_max);
else
    error('Error. Number of array dimensions not supported.')
end
%-------------------------------------------------------------------------%
    function [x,y,z] = twodim(A,xy_ratio,z_max)
        [x,y,z] = find(A);
        x = im2double(x) * xy_ratio;
        y = im2double(y) * xy_ratio;
        z = im2double(z);
        z = (z/max(z,[],'all')) * z_max;
    end
end
