function [X,relerr,PSNR]= run_alg2(R,G,B,IMG,omegaR,omegaG,omegaB,n_ss_pixels)
n = size(R,1);
delta =  n^2/n_ss_pixels;
tol = 1e-9;
tau = 20*n;
l = 15;
k_max = 250;

PMR = omegaR.*double(R);
PMG = omegaG.*double(G);
PMB = omegaB.*double(B);

XR = alg2(omegaR,PMR,delta,tol,tau,l,k_max);
XG = alg2(omegaG,PMG,delta,tol,tau,l,k_max);
XB = alg2(omegaB,PMB,delta,tol,tau,l,k_max);

X = zeros([size(R),3]);
X(:,:,1) = XR;
X(:,:,2) = XG;
X(:,:,3) = XB;

relerr = norm(X-double(IMG),'fro')/norm(double(IMG),'fro');
PSNR = psnr(uint8(X),IMG,255);
end

