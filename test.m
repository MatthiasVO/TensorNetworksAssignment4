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



omega_l = 512*512;
subset_percentage = 0.85;

omega = zeros(omega_l,1);
subset = round(omega_l*subset_percentage);

omega(1:subset) = 1;
omega = omega(randperm(omega_l));
omega = reshape(omega,size(R));

imshow(omega)
imshow(uint8(omega.*double(IMG)))



tau = 2;

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







