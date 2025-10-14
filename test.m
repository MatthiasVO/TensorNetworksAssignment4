clear
clc

IMG = imread("4.2.07.tiff");
R = IMG(:,:,1);
G = IMG(:,:,2);
B = IMG(:,:,3);

Sr = svd(double(R));
Sg = svd(double(G));
Sb = svd(double(B));

%plot log scale 
semilogy([Sr Sg Sb])


n = size(R,1);
omega_l = n*n;
subset_percentage = 0.85;

omega = zeros(omega_l,1);
m = round(omega_l*subset_percentage);

omega(1:m) = 1;
omega = omega(randperm(omega_l));
omega = reshape(omega,size(R));

imshow(omega)
PM = omega.*double(IMG);
imshow(uint8(PM));




delta = 1.2 * n^2/m;
tol = 1e-4;
tau = 5*n;
l = 5;
k_max = 150;

%%%%%%%%%

k0 = ceil(tau/delta/norm(PM,'fro'));
r0 = 0;
Y = k0*delta*M;
r = zeros(k_max,1);
s = zeros(k_max,1);

for k =2:k_max
    s(k) = r(k-1) + 1;
    while  sigma(s(k)-l, k-1) <= tau
        [U,S,V] = svd(Y(:,:,k-1),"vector");
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

    U * diag(S-tau)*V';

end







