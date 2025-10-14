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
subset_percentage = 0.50;

omega = zeros(omega_l,1);
m = round(omega_l*subset_percentage);

omega(1:m) = 1;
omega = omega(randperm(omega_l));
omega = reshape(omega,size(R));

imshow(omega)
PM = omega.*double(R);
imshow(uint8(PM));




delta = 1.2 * n^2/m;
tol = 1e-4;
tau = 5*n;
l = 5;
k_max = 150;

%%%%%%%%%

PMR = omega.*double(R);
PMG = omega.*double(G);
PMB = omega.*double(B);
XR = alg2(omega,PMR,delta,tol,tau,l,k_max);
XG = alg2(omega,PMG,delta,tol,tau,l,k_max);
XB = alg2(omega,PMB,delta,tol,tau,l,k_max);

X = zeros([size(R),3]);
X(:,:,1) = XR;
X(:,:,2) = XG;
X(:,:,3) = XB;

imshow(uint8(X));




