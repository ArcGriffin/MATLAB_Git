function bimages = imsBinarize(images,varargin)
%IMSBINARIZE Summary of this function goes here
%   Detailed explanation goes here
    s = size(images);
    bimages = false(s);

    % Checking the array class in order to determine the proper
    % threshold
    switch class(images)
        case 'uint8'
            max_val = 255;
        case 'uint16'
            max_val = 65535;
        case 'double'
            max_val = 1;
        otherwise
            error('Error. Array class not supported.')
    end


    % Thresholding the images based on the input of the user
    if isempty(varargin)
        threshold = floor(mean2(images) + (3 * std2(images)));
    elseif length(varargin) == 1
        threshold = floor(varargin{1} * max_val);
    else
        error('Error. Incorrect number of inputs.')
    end  

    bimages(images > threshold) = 1;
end

