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

%imshow(omega)
PM = omega.*double(R);
%imshow(uint8(PM));


%% alg 4
clc
tic
OMEGA = zeros(size(IMG));
OMEGA(:,:,1) = omega;
OMEGA(:,:,2) = omega;
OMEGA(:,:,3) = omega;

alp = [1,1,1]*0.1;
bet = [1,1,1];
gam = [1 1 1]*500;
tol = 10e-10;
[Xtensor,Ytensor,Mtensor] = alg4(double(IMG),OMEGA,alp,bet,gam,tol);
toc


figure(1);
tiledlayout(2,2, 'Padding', 'none', 'TileSpacing', 'none');

nexttile;
imshow(IMG);
title('original');

nexttile;
imshow(uint8(omega) .* IMG);
title('Omega');

nexttile;
imshow(uint8(Xtensor));
title('Tensor');


%% alg 2
delta =  1* n^2/m;
tol = 1e-9;
tau = 20*n;
l = 15;
k_max = 1000;


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

nexttile;
imshow(uint8(X));
title('Matrix');





