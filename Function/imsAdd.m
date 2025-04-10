function f = imsAdd(images,method,varargin)
%IMSADD Summary of this function goes here
%   Detailed explanation goes here
    s = size(images);

    if strcmp(method,'plain')
        f = false(s(1:2));

        for k = 1:s(3)
            if k == 1
                f = images(:,:,1);
            else
                f = or(f,images(:,:,k));
            end
        end

    elseif strcmp(method,'weight')
        reverse = false;
        if length(varargin) > 1
            error('Error. Invalid number of input arguments.')
        elseif length(varargin) == 1
            if strcmp(varargin{1},'flip')
                reverse = true;
            end
        end
        
        max_val = 65535;
        start = 0; %floor(0.1*max_val);
        j = floor(linspace(max_val,start,s(3)));
        
        if reverse
            j = flip(j);
        end
        
        f = zeros(s(1:2),'uint16');

        for k = s(3):-1:1
            f(images(:,:,k) == 1) = j(k);
        end
    else 
        error('Error. Invalid image addition method.');
    end
end


