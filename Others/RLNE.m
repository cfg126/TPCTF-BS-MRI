function cp=RLNE(im_ori,im_rec)
%% evaluation the reconstruction error with relative L2 norm error
%% Xiaobo Qu
%% Xiamen University
%% April 16,2011
L2_error=im_ori-im_rec;
cp=norm(L2_error(:),2)./norm(im_ori(:),2);