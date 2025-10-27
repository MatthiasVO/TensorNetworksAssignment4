function [X, relerr,PSNR] = run_alg4(IMG,omegaR,omegaG,omegaB)


OMEGA = zeros(size(IMG));
OMEGA(:,:,1) = omegaR;
OMEGA(:,:,2) = omegaG;
OMEGA(:,:,3) = omegaB;

a = .1;
b = 1;
g = 500;

alp = [1,1,1]*a;
bet = [1,1,1]*b;
gam = [1 1 1]*g;

k_max = 60;

X = alg4(double(IMG),OMEGA,alp,bet,gam,k_max,0);

relerr = norm(X-double(IMG),'fro')/norm(double(IMG),'fro');
PSNR = psnr(uint8(X),IMG);
end

