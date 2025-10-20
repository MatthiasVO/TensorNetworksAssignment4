function M = D(X,Y,tau,n,alp,bet)
    Xi = mode_n_matricization(X,n);        
    Yi = mode_n_matricization(Y,n);
        
    [U,S,V] = svd((alp*Xi + bet*Yi)/(alp+bet),"econ");
    St = max(S-tau,0);
    Mi = U*St*V';


    dim_X = size(X);
    J = size(X,n);
    dim_X(n) = [];

    M = reshape(Mi,[J dim_X]);

    
    a1 = 2:n;
    a2 = n+1:length(size(M));
    permute_indices = [a1 1 a2];
    M = permute(M,permute_indices);
end