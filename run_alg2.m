function [X,relerr,PSNR]= run_alg2(R,G,B,IMG,omega,n_ss_pixels)
n = size(R,1);
delta =  1* n^2/n_ss_pixels;
tol = 1e-9;
tau = 20*n;
l = 15;
k_max = 50;

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

relerr = norm(X-double(IMG),'fro')/norm(double(IMG),'fro');
PSNR = psnr(uint8(X),IMG,255);
end

