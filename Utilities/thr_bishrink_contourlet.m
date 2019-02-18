function thr_coef = thr_bishrink_contourlet(coef,sigma_n)
% suppose that every level is decomposed the same direction

%set the window size and the corresponding filter
windowsize = 7;
windowfilt = ones(1,windowsize)/windowsize;

n_Lvl = length(coef);%5

Nsig = sigma_n; % estimation sigma of noise

thr_coef = coef;
for scale = 0:n_Lvl-3
L=length(coef{n_Lvl-scale});
   for l  = 1:L
            Y_coef = coef{n_Lvl-scale}{l};
            Y_parent = coef{n_Lvl-scale-1}{l};
            if scale>0
            Y_parent = expandx(Y_parent);
            end
            Wsig = conv2(windowfilt,windowfilt,(abs(Y_coef)).^2,'same');           
            Ssig = sqrt(max(Wsig - Nsig.^2, eps));
            T = sqrt(3)*Nsig^2./Ssig; 
  
            Y_coef = bishrink(Y_coef, Y_parent, T);
            thr_coef{n_Lvl-scale}{l} = Y_coef;
   end
end
    

end