function params = cwavelet(img,nLvl,n)

[ky,kx] = size(img); 

if n==3
cp = [-33/32,33/32,pi];
ep = [69/128,69/128,50/128];
Np = [1,1,1];
end

if n==4
cp = [-291/256,0,291/256,pi];
ep = [1/2,35/128,27/64,1/2];
Np = [1,1,1,1];
end

if n==6
cp = [-(pi+119/128)/2, -119/128, 0, 119/128, (pi+119/128)/2, pi];
ep = [115/256, 81/128, 35/128, 81/128, 115/256, 115/256];
Np = [1,1,1,1,1,1];
end

for j = 1:nLvl 
   xcp{j} = cp; xep{j} = ep; xNp{j} = Np;
   ycp{j} = cp; yep{j} = ep; yNp{j} = Np;
end
filter_params.xcp = xcp; filter_params.xep = xep; filter_params.xNp = xNp;
filter_params.ycp = ycp; filter_params.yep = yep; filter_params.yNp = yNp;
filter_params.choice = 1;
filter_params.nX = kx*2.^[0:-1:-nLvl];
filter_params.nY = ky*2.^[0:-1:-nLvl];
filter_params.nLvl = nLvl;
% generate filters
params.dwnsmpl_low = ones(1,nLvl);
params.dwnsmpl_high = ones(1,nLvl);
params.nLvl = nLvl;
params.filtZ = tensor_fr_d2filtZ(filter_params);


