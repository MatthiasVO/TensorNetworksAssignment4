function Mi = D(X,Y,tau,mode,alp,bet)
    Xi = mode_n_matricization(X,mode);        
    Yi = mode_n_matricization(Y,mode);
        
    [U,S,V] = svd( ...
        (alp*Xi + bet*Yi)/(alp+bet), ...
        "vector");
    St = diag(max(S-tau),0);
    Mi = U*St*V';
end


