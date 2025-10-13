function Xopt = alg2(omega,M,delta,tol,tau,l,k_max)

k0 = ceil(tau/delta/norm(M,'fro'));
r0 = 0;

Y = k0*delta*M;



r = zeros(k_max,1);
s = zeros(k_max,1);
for k =2:k_max
    s(k) = r(k-1) + 1;
    while  sigma(s(k)-l, k-1) <= tau
        [U,S,V] = svd(Y(:,:,k-1),"vector");
        U = U(:,1:s(k));
        V = V(1:s(k),:);
        S = S(1:s(k));

        s(k) = s(k) + l;
    end
    r_index = S >= tau;
end



%ALG2 Summary of this function goes here
%   Detailed explanation goes here




Xopt = 1;
end

