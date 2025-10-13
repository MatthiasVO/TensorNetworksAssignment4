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

semilogy([Sr Sg Sb])

