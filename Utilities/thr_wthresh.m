function thr_coef = thr_wthresh(coef,threshold)

coef_length = length(coef);
n_Lvl = coef_length-1;
coef{coef_length}= wthresh(coef{coef_length},'s',threshold);

thr_coef = coef;
for scale = 1:n_Lvl
   L = length(coef{scale});
   for l  = 1:L
            Y_coef = coef{scale}{l};
            coe_tmp= wthresh(Y_coef,'s',threshold);
            thr_coef{scale}{l} = coe_tmp;
   end
end
end