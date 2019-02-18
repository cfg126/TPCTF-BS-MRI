function res =TPCTFs(nLvl,n,row,column)
% nLv1:decomposition level
% nrm:?
% n: TPCTF3,TPCTF4,TPCTF6
% row column:image size
res.adjoint = 0;
res.nLvl = nLvl;
imgtemp=ones(row,column);
if n==3
    params     = cwavelet(imgtemp,nLvl,n);
    load 'nrm_TPCTF3.mat'; 
end

if n==4
    params     = cwavelet(imgtemp,nLvl,n);
    load 'nrm_TPCTF4.mat'; 
end

if n==6
    params     = cwavelet(imgtemp,nLvl,n);
    load 'nrm_TPCTF6.mat'; 
end
res.nrm = nrm;
res.n = n;
res.params = params;
res.fout   = tensor_frdec2d(imgtemp,params);

res = class(res,'TPCTFs');
