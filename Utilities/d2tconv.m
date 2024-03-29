function y = d2tconv(v,u_r,stp_r,u_c,stp_c)
%% 2D time domain convolution
%
% INPUT
%   v: 2D signal
%   u_r: input row convolution filter u_r = [u_r(stp_r), u_r(stp_r+1),...]
%   u_c: input column convolution filter u_c = [u_c(stp_c), u_c(stp_c+1),...]
%
% OUTPUT:
%   y: v circular convolute with u_r tensor of u_c
%      i.e., y = v*[u_c(x)u_r], (x) means tensor

[m,n]  = size(v);
ur_len = length(u_r); 
uc_len = length(u_c); 

u_r0 = zeros(1,n);
u_r0(1:ur_len) = u_r;
u_r0 = circshift(u_r0,[0,stp_r]);

u_c0 = zeros(m,1);
u_c0(1:uc_len) = u_c.';
u_c0 = circshift(u_c0.',[0,stp_c]);
u_c0 = u_c0.';

u = u_c0*u_r0;
y = ifft2(fft2(v).*fft2(u));
end