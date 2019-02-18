function y = d2fconv(fv,fu)
%% 2D convolution
%
%  INPUT:
%    fv: signal in freqeuncy domain
%    fu: filter in frequency domain same size as fv;
%  OUTPUT:
%    y = fv.*fu
 
y = fv.*fu;
end