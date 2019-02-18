clc;
clear;
clear classes;
close all;
% im_ori = double(imread('bust.jpg'));
load 'T2wBrain_slice_27.mat'
im_ori = abs(im_ori);
im_ori=im_ori/(max(max(im_ori)));
% load('radialmask4.mat');
load('cartesianmask4.mat')

% undersampling k-space
[row,column] = size(mask);
Fu = Fu_downsample(mask,row,column);
y = Fu*im_ori;

%% Tight frame Tensor product complex tight framelets 
params_TPCTF6.gamma=1;
params_TPCTF6.iter_max = 200;
nLvl  = 4;
params_TPCTF6.Fu  = Fu; 
params_TPCTF6.tol = 1e-6;
params_TPCTF6.im_ori = im_ori;

TPCTFs_psi = TPCTFs(nLvl,6,row,column);
params_TPCTF6.psi = TPCTFs_psi;
fprintf('TPCTF6-Bishrink-pFISTA solving . . .\n')
out = Solver_pFISTA_TPCTF(y,params_TPCTF6);
fprintf('Done TPCTF6-Bishrink-pFISTA solver!\n\n')

imshow([im_ori out.im_rec])


