function out = Solver_pFISTA_TPCTF(y,params_TPCTF);
gamma = params_TPCTF.gamma;
tol_error =params_TPCTF.tol;

iter_max  = params_TPCTF.iter_max;         
img=params_TPCTF.im_ori;
Fu=params_TPCTF.Fu ;
imgMasked= Fu'*y;
psi = params_TPCTF.psi;
im_rec_last = imgMasked;
im_rec = imgMasked;
im_rec_hat = im_rec;
t_last = 1;
im_diff_err=1;
iter=1;
while (im_diff_err>=tol_error)&&(iter<=iter_max)  

    im_rec=im_rec_hat + gamma*(Fu'*(y - Fu*im_rec_hat));

    coefs = psi*im_rec;

    thr_coefs =  thr_bishrink(coefs);

    im_rec = psi'*thr_coefs; 

    t_now = (1 + sqrt(1 + 4*t_last*t_last))/2;

    im_rec_hat = im_rec + (t_last - 1)/t_now*(im_rec - im_rec_last);

     if iter>1
            im_diff_err = norm(im_rec_last(:) - im_rec(:),2)/norm(im_rec_last(:),2);
     end

    im_rec_last = im_rec;
    t_last = t_now;

    out.rlne_iter(iter) = RLNE(img,im_rec);
    out.ssim_iter(iter) = ssim(abs(img),abs(im_rec));
    out.psnr_iter(iter) = psnr(img,im_rec);

    fprintf('TPCTF-pFISTA ---> ssim: %.6f \t RLNE: %.6f \t  PSNR: %.6f \t #iter %d \n',out.ssim_iter(iter),out.rlne_iter(iter),out.psnr_iter(iter),iter);
    iter = iter +1;

end
out.im_rec =im_rec;

end

