function thr_coef = thr_wthresh2(coef,threshold)
coef_length = length(coef);
n_Lvl = coef_length-1;
coef{coef_length}{1}{1}=wthresh(coef{coef_length}{1}{1},'s',threshold);
coef{coef_length}{1}{2}=wthresh(coef{coef_length}{1}{2},'s',threshold);
coef{coef_length}{2}{1}=wthresh(coef{coef_length}{2}{1},'s',threshold);
coef{coef_length}{2}{2}=wthresh(coef{coef_length}{2}{2},'s',threshold);
w=coef;

I=sqrt(-1);

for j = 1:n_Lvl
    % loop thru subbands
    for s1 = 1:2
        for s2 = 1:3
%             C1 = w{j}{1}{s1}{s2};
%             C2 = w{j}{2}{s1}{s2};
%             C1= wthresh(C1,'s',threshold);
%             C2= wthresh(C2,'s',threshold);
%             w{j}{1}{s1}{s2} = C1;
%             w{j}{2}{s1}{s2} = C2;
            C = w{j}{1}{s1}{s2}+I*w{j}{2}{s1}{s2};
            C= wthresh(C,'s',threshold);
            w{j}{1}{s1}{s2} = real(C);
            w{j}{2}{s1}{s2} = imag(C);
            
        end
    end
end
thr_coef=w;

end