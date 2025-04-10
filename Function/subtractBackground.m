function G = subtractBackground(F,g)
%SUBTRACTBACKGROUND Subtracts the image g from the stack of images F.
%   Detailed explanation goes here

if ndims(F) ~= 3
    error('Error. F must be a three-dimensional array')
end
    
if ~(size(F,[1 2]) == size(g))
    error('Error. The images inside of F must be of the same dimension as g.')
end

G = zeros(size(F),'uint8');

for i = 1:size(F,3)
    G(:,:,i) = imsubtract(F(:,:,i),g);
end


end

