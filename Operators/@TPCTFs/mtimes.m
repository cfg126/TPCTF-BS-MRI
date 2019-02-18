function res = mtimes(a,b)

if isa(a,'TPCTFs') == 0
    error('In  A.*B only A can be TPCTFs');
end

if a.adjoint
    thr_coefs       = tensor_nrmCoefs(b,a.nrm,-1);
    foutNew         = a.fout;
    foutNew.coefs   = thr_coefs;
%--------------------------------------------------------------------
    im_rec   = tensor_frrec2d(foutNew,a.params);
    res       = abs(im_rec);    

else
    fout      = tensor_frdec2d(b,a.params);
    coefs     = fout.coefs;
    coefs     = tensor_nrmCoefs(coefs,a.nrm,1);
    res       = coefs;
end
    
end