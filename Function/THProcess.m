function [THLt,THLs,THLb,THLf,THLf2] = THProcess(THL)
%THPROCESS Summary of this function goes here
%   Detailed explanation goes here

% Verify the correct number of inputs
s1 = size(THL);



% Binarize stacks of images
THLb = imsBinarize(THL,0.10);

%Close images
% se = strel('disk',3);
% for i = 1:s1(3)
%     THLb(:,:,i) = imopen(THLb(:,:,i),se);
%     THLb(:,:,i) = imclose(THLb(:,:,i),se);
% end


% Subtract stacks of binary images
THLs = imsSubtract(THLb,'new');

% Thinning
THLt = imsThin(THLs,150);

% Add images to create a full reconstruction of the dust pile
THLf = imsAdd(THLt,'weight');
THLf2 = imsAdd(THLb,'weight');

%-------------------------------------------------------------------------%
    function simages = imsSubtract(images,method)
        [w,l,h] = size(images);
        simages = false(w,l,h-1);
        
        if strcmp(method,'xor')
            for k = 1:h-1
                simages(:,:,k) = xor(images(:,:,k),images(:,:,k+1));
            end
        elseif strcmp(method,'and')
            for k = 1:h-1
                simages(:,:,k) = and(images(:,:,k),images(:,:,k+1));
            end
        elseif strcmp(method,'new')
            for k = 1:h-1
                if k == 1
                    imt = images(:,:,k);
                else
                    imt = or(imt,images(:,:,k));
                end
                
                img = false(w,l);
                img((imt == 0) & (images(:,:,k+1) == 1)) = 1;
                simages(:,:,k) = img;
            end
        else
            error('Error. Invalid subtraction method')
        end
    end

%-------------------------------------------------------------------------%
%     function f = imsAdd(images,method)
%         s = size(images);
%         
%         if strcmp(method,'plain')
%             f = false(s(1:2));
% 
%             for k = 1:s(3)
%                 if k == 1
%                     f = images(:,:,1);
%                 else
%                     f = or(f,images(:,:,k));
%                 end
%             end
%             
%         elseif strcmp(method,'weight')
%             max_val = 65535;
%             start = floor(0.1*max_val);
%             j = floor(linspace(max_val,start,s(3)));
%             
%             f = zeros(s(1:2),'uint16');
%             
%             for k = s(3):-1:1
%                 f(images(:,:,k) == 1) = j(k);
%             end
%         else 
%             error('Error. Invalid image addition method.');
%         end
%             
%     end

%-------------------------------------------------------------------------%
    function F = imsThin(images,l)
        element = strel('disk',l);
        s = size(images);
        F = false(s);
        
        for k = 1:s(3)
            F(:,:,k) = bwmorph(imclose(images(:,:,k),element),'thin',Inf);
        end
    end

%-------------------------------------------------------------------------%
end


