function X = alg2(omega,PM,delta,tol,tau,l,k_max)

k0 = ceil(tau/delta/norm(PM,'fro'));
r0 = 0;
Y = k0*delta*PM;
r = zeros(k_max,1);
s = zeros(k_max,1);

for k =2:k_max
    
    s(k) = r(k-1) + 1;
    while true
        [U,S,V] = svd(Y,"vector");
        U = U(:,1:s(k));
        V = V(:,1:s(k));
        S = S(1:s(k));
        if S(s(k)) <= tau 
            break 
        end
        s(k) = s(k) + l;
    end
    r_index = (S < tau);
    r(k) = find(r_index,1)-1;

    X = U * diag(S-tau)*V';
    error = norm(omega.*(X-PM),'fro')/norm(PM,'fro');
    if error < tol
        break
        
    end
    fprintf("\talg2 timestep k: %d, e: %e\n",k,error);
    Y = omega.*(Y + delta*(PM-X) );
end
