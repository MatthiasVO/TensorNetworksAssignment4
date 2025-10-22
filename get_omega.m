function [omega,n_ss_pixels] = get_omega(IMG,subset_per)

n = size(IMG,1);
shape = size(IMG,1:2);
omega_len = n*n;
n_ss_pixels = round(omega_len*subset_per);
omega = zeros(omega_len,1);

omega(1:n_ss_pixels) = 1;
omega = omega(randperm(omega_len));
omega = reshape(omega,shape);



end

%ss_img = omega.*double(IMG);
% omega2 = conv2(omega,ones(1,1),'same');
% omega = 1-omega2;
%imshow(uint8(PM));
% figure;
% imshow(omega2)