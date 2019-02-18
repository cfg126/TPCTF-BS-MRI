function thr_coef = thr_bishrink(coef)

%set the window size and the corresponding filter
windowsize = 7;
windowfilt = ones(1,windowsize)/windowsize;

n_Lvl = length(coef)-1;

level_length=length(coef{1});
sum=0;
for i=1:level_length
sum=sum+median(abs(coef{1}{i}(:)));
end
sum=sum/level_length;
Nsig=sum/0.6745;
thr_coef = coef;
for scale = 1:n_Lvl-1
   L = length(coef{scale});
   for l  = 1:L
            Y_coef = coef{scale}{l};
            Y_parent = coef{scale+1}{l};
            Y_parent = expandx(Y_parent);
            Wsig = conv2(windowfilt,windowfilt,(abs(Y_coef)).^2,'same');           
            Ssig = sqrt(max(Wsig - Nsig.^2, eps));
            T = sqrt(3)*Nsig^2./Ssig; 
            Y_coef = bishrink(Y_coef, Y_parent, T);
            thr_coef{scale}{l} = Y_coef;
   end
end
    

end