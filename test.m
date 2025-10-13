disp("hallo")
disp("Hallo world!!!!")
A = 3;
disp("vo voor badhoevedorp")

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
subset_percentage = 0.50;

omega = zeros(omega_l,1);
subset = round(omega_l*subset_percentage);

omega(1:subset) = 1;
omega = omega(randperm(omega_l));
omega = reshape(omega,size(R));

imshow(omega)











rand


