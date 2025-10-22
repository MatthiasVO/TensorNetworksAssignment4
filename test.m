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
figure(1);
nexttile;
imshow(IMG);
saveas(gcf,'original.png')
%title('original image');
figure(2);
plot(Sr,'r');
hold on
plot(Sg,'g');
plot(Sb,'b');
%legend('red channel', 'green channel', 'blue channel');
xlim([-1 100]);
hold off
saveas(gcf,'RGB_SVD.svg')
%title('Singular values of the RGB-channels');


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

OMEGA = zeros(size(IMG));
OMEGA(:,:,1) = omega;
OMEGA(:,:,2) = omega;
OMEGA(:,:,3) = omega;

a = 0.1;
b = 1;
g = 500;

alp = [1,1,1]*a;
bet = [1,1,1]*b;
gam = [1 1 1]*g;

alp2 = [1,1,1]*a;
bet2 = [1,1,1]*b;
gam2 = [1 1 1]*g;
tol = 10e-10;
k_max = 60;
k_max2 = 100;
[Xtensor,Ytensor,Mtensor] = alg4(double(IMG),OMEGA,alp,bet,gam,tol,k_max);
[Xtensor2,Ytensor2,Mtensor2] = alg4(double(IMG),OMEGA,alp2,bet2,gam2,tol,k_max2);


figure(1);
tiledlayout(1,3, 'Padding', 'none', 'TileSpacing', 'none');

nexttile;
imshow(IMG);
title('original');

%nexttile;
%imshow(uint8(omega) .* IMG);
%title('Omega');

nexttile;
imshow(uint8(Xtensor));
title('Tensor');
nexttile;
imshow(uint8(Xtensor2));
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





