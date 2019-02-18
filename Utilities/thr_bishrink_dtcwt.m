function thr_coef = thr_bishrink_dtcwt(coef,sigma_n)

%set the window size and the corresponding filter
windowsize = 7;
windowfilt = ones(1,windowsize)/windowsize;

n_Lvl = length(coef)-1;

Nsig = sigma_n; % estimation sigma of noise
I=sqrt(-1);
W=coef;

for scale = 1:n_Lvl-1
    for dir = 1:2
        for dir1 = 1:3

            % Noisy complex coefficients
            %Real part
            Y_coef_real = W{scale}{1}{dir}{dir1};
            % imaginary part
            Y_coef_imag = W{scale}{2}{dir}{dir1};
            % The corresponding noisy parent coefficients
            %Real part
            Y_parent_real = W{scale+1}{1}{dir}{dir1};
            % imaginary part
            Y_parent_imag = W{scale+1}{2}{dir}{dir1};
            % Extend noisy parent matrix to make the matrix the
            % same size as the coefficient matrix.
            Y_parent_real  = expandx(Y_parent_real);
            Y_parent_imag   = expandx(Y_parent_imag);

            % Signal variance estimation
            Wsig = conv2(windowfilt,windowfilt,(Y_coef_real).^2,'same');
            Ssig = sqrt(max(Wsig-Nsig.^2,eps));

            % Threshold value estimation
            T = sqrt(3)*Nsig^2./Ssig;

            % Bivariate Shrinkage
            Y_coef = Y_coef_real+I*Y_coef_imag;
            Y_parent = Y_parent_real + I*Y_parent_imag;
            Y_coef = bishrink(Y_coef,Y_parent,T);
            W{scale}{1}{dir}{dir1} = real(Y_coef);
            W{scale}{2}{dir}{dir1} = imag(Y_coef);

        end
    end
end
    
thr_coef=W;
end