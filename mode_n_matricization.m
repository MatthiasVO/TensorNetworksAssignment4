function X = mode_n_matricization(X,n)
% MODE_K_MATRICIZATION takes a tensor X as input and a mode n such
% that n<ndims(X) and returns the mode-n matricization of X.
% INPUTS tensor X, mode n.
% OUPUT mode-n matricization of X.

I_n = size(X,n);

I_m = size(X);
I_m(n) = [];

indices = 1:length(size(X));
indices(n) = [];
permute_indices = [n indices];

X = permute(X,permute_indices);
X = reshape(X,[I_n,prod(I_m)]);

end