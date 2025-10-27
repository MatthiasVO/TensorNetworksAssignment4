clear
clc

%% load image
rng(0)
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

%% same omega for every color
ss = [.85 .75  .50 .30 ];
k=3;

relerrMAT = zeros(length(ss),1);
relerrTEN = zeros(length(ss),1);

psnrMAT = zeros(length(ss),1);
psnrTEN = zeros(length(ss),1);

comp_timeMAT = zeros(length(ss),1);
comp_timeTEN = zeros(length(ss),1);
for subset = ss
    K = k-2;
    
    [omega,n_subset_pixels] = get_omega(IMG,subset);
    tic
    [Xmat, relerrmat,psnrmat] = run_alg2(R,G,B,IMG,omega,omega,omega,n_subset_pixels);
    comp_timeMAT(K) = toc;

    tic
    [Xtensor, relerrtensor,psnrtensor]= run_alg4(IMG,omega,omega,omega);
    comp_timeTEN(K) = toc;
    
    relerrMAT(K) = relerrmat;
    relerrTEN(K) = relerrtensor;
    psnrTEN(K) = psnrtensor;
    psnrMAT(K) = psnrmat;
    %nexttile;
    %imshow(IMG);
    figure(k);
    tiledlayout(1,3, 'Padding', 'none', 'TileSpacing', 'none');

    nexttile;
    imshow(uint8(omega) .* IMG);
    
    nexttile;
    imshow(uint8(Xmat));

    nexttile;
    imshow(uint8(Xtensor));
    
    pathh = "figures/";
    filename = "compare_MT_" + string(subset) + ".png";
    exportgraphics(gcf,pathh + filename,'Resolution',1600);
    k=k+1;
end




%% different omegas for the different colors

SS = [.75, .75, .75;
      .90 .90 .25;
      .90 .25 .25];

N = size(SS,1);
relerrMATshuff = zeros(length(ss),N);
relerrTENshuff = zeros(length(ss),N);

psnrMATshuff = zeros(length(ss),N);
psnrTENshuff = zeros(length(ss),N);

comp_timeMATshuff = zeros(length(ss),N);
comp_timeTENshuff = zeros(length(ss),N);


k = 7;
for n = 1:N
    ss = SS(n,:);

    [omegaR,nspR] = get_omega(IMG,ss(1));
    [omegaG,nspG] = get_omega(IMG,ss(2));
    [omegaB,nspB] = get_omega(IMG,ss(3));
    nsp_avg = (nspR+nspG+nspB)/3;

    tic
    [Xmat, relerrmat,psnrmat] = run_alg2(R,G,B,IMG,omegaR,omegaG,omegaB,nsp_avg);
    comp_timeMATshuff(n) = toc;
    
    tic
    [Xtensor, relerrtensor,psnrtensor]= run_alg4(IMG,omegaR,omegaG,omegaB);
    comp_timeTENshuff(K) = toc;

    relerrMATshuff(n) = relerrmat;
    relerrTENshuff(n) = relerrtensor;
    psnrTENshuff(n) = psnrtensor;
    psnrMATshuff(n) = psnrmat;
    
    maskIMG = zeros(size(IMG));
    maskIMG(:,:,1) = uint8(omegaR);
    maskIMG(:,:,2) = uint8(omegaG);
    maskIMG(:,:,3) = uint8(omegaB);
    
    figure(k);
    tiledlayout(2,2, 'Padding', 'none', 'TileSpacing', 'none');
    nexttile; imshow(IMG);
    nexttile; imshow(uint8(maskIMG).*IMG);
    nexttile; imshow(uint8(Xmat));
    nexttile; imshow(uint8(Xtensor));

    pathh = "figures/";
    filename = "compare_MT_" + string(ss(1)*100) +string(ss(2)*100) +string(ss(3)*100) + ".png";
    exportgraphics(gcf,pathh + filename,'Resolution',1600);
    k=k+1;
end




%% %% same omega for every color with additive uniform noise
n_noise = 40;
noise = rand(size(IMG))*2*n_noise-n_noise;
IMGnoise = uint8(double(IMG)+noise);

ss = [ .75 .4];

relerrMATnoise = zeros(length(ss),1);
relerrTENnoise = zeros(length(ss),1);

psnrMATnoise = zeros(length(ss),1);
psnrTENnoise = zeros(length(ss),1);

comp_timeMATnoise = zeros(length(ss),1);
comp_timeTENnoise = zeros(length(ss),1);
k = 10;
R = IMGnoise(:,:,1);
G = IMGnoise(:,:,2);
B = IMGnoise(:,:,3);
for subset = ss
    K = k-9;
    
    [omega,n_subset_pixels] = get_omega(IMGnoise,subset);
    tic
    [Xmat, relerrmat,psnrmat] = run_alg2(R,G,B,IMGnoise,omega,omega,omega,n_subset_pixels);
    comp_timeMATnoise(K) = toc;

    tic
    [Xtensor, relerrtensor,psnrtensor]= run_alg4(IMGnoise,omega,omega,omega);
    comp_timeTENnoise(K) = toc;
    
    relerrMATnoise(K) = relerrmat;
    relerrTENnoise(K) = relerrtensor;
    psnrTENnoise(K) = psnrtensor;
    psnrMATnoise(K) = psnrmat;


    figure(k);
    tiledlayout(2,3, 'Padding', 'none', 'TileSpacing', 'none');
    nexttile;
    imshow(IMG)
    
    nexttile;
    imshow(IMGnoise)

    nexttile;
    imshow(uint8(omega) .* IMGnoise);
    
    nexttile;
    imshow(uint8(Xmat));

    nexttile;
    imshow(uint8(Xtensor));
    
    pathh = "figures/";
    filename = "compare_MTnoise_" + string(subset) + "_noise"+string(n_noise) + ".png";
    exportgraphics(gcf,pathh + filename,'Resolution',1600);
    k=k+1;
end










