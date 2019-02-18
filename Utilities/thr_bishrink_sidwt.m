function thr_coef = thr_bishrink_sidwt(coef,sigma_n,nLvl)

%set the window size and the corresponding filter
windowsize = 7;
windowfilt = ones(1,windowsize)/windowsize;

seg1=256*ones(13,1);
res=mat2cell(coef,256,seg1);


Nsig = sigma_n; % estimation sigma of noise

thr_coef = res;
for scale = 0:nLvl-2
   for i  = 1:3
            Y_coef = res{1+i+scale*3};
            Y_parent = res{i+4+scale*3};

%             Y_parent = expandx(Y_parent);
            Wsig = conv2(windowfilt,windowfilt,(abs(Y_coef)).^2,'same');           
            Ssig = sqrt(max(Wsig - Nsig.^2, eps));
            T = sqrt(3)*Nsig^2./Ssig;  
            Y_coef = bishrink(Y_coef, Y_parent, T);
            thr_coef{1+i+scale*3} = Y_coef;
   end
end
thr_coef=cell2mat(thr_coef);

end