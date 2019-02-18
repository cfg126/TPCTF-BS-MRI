function y = d1tconv(v,u,stp)
%% circular convolution 
%
% INPUT:
%   u: filter  
%   stp : starting point of u = [u(stp),u(stp+1),...,u(0),...];
%   v: signal
% OUPUT:
%   y: circular convulution of v*u;

N = length(v);
temp = cconv(u,v,N);
y = circshift(temp,[0, stp]);