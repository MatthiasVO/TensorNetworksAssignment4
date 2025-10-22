clear
clc

%% load image
IMG = imread("4.2.07.tiff");

R = IMG(:,:,1);
G = IMG(:,:,2);
B = IMG(:,:,3);

%% plot RGB SVD
Sr = svd(double(R));
Sg = svd(double(G));
Sb = svd(double(B));

figure(1);
imshow(IMG);
%saveas(gcf,'figures/original.png')

figure(2);
plot(Sr,'r');
hold on
plot(Sg,'g');
plot(Sb,'b');
xlim([-1 100]);
hold off
%saveas(gcf,'figures/RGB_SVD.svg')

%% compute omega
ss = [ .75, .85];
k=3;
for subset = ss
    figure(k);
    tiledlayout(2,2, 'Padding', 'none', 'TileSpacing', 'none');
    
    [omega,n_subset_pixels] = get_omega(IMG,subset);
    [Xmat, relerrmat,psnrmat] = run_alg2(R,G,B,IMG,omega,n_subset_pixels);
    [Xtensor, relerrtensor,psnrtensor]= run_alg4(IMG,omega);

    nexttile;
    imshow(IMG);
    
    nexttile;
    imshow(uint8(omega) .* IMG);
    
    nexttile;
    imshow(uint8(Xmat));

    nexttile;
    imshow(uint8(Xtensor));
    
    pathh = "figures/";
    filename = "compare_MT_" + string(subset)+ ".svg";
    saveas(gcf,pathh + filename)
    k=k+1;
end
string(datetime)