function g = splitmerge(varargin)
Q=2^nextpow2(max(size(a)));
[M, N] = size(a);
f = padarray(a, [Q - M, Q - N], 'post');
Z=qtdecomp(f, @split_test, mindim, fun);
Lmax = full(max(Z(:)));
g = zeros(size(f));
MARKER =  zeros(size(f));

for K = 1:Lmax
    [vals, r, c] = qtgetblk(f, Z, K);
    if ~isempty(vals)
        for I = 1:length(r)
            xlow = r(I); ylow = c(I);
            xhigh = xlow + K - 1; yhigh = ylow + K - 1;
            region = f(xlow:xhigh, ylow:yhigh);
            flag = fun (region);
            if flag
                g(xlow:xhigh, ylow:yhigh) = 1;
                MARKER(xlow, ylow) = 1;
            end
        end
    end
end
g = bwlabel(imreconstruct(MARKER, g));
g = g(1:M, 1:N);




