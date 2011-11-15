function [] = auto_mosaic( I1,I2,p1,p2,d1,d2 )
% I1 and I2 are two images needed to be mosaiced
% p1, p2, d1 and d2 are SIFT features of two images

[m1 m2] = sift_matcher(p1,p2,d1,d2);
[H T] = RANSAC_ndlt(m1,m2);
K = blend(I1,I2,H);
imshow(K,[]);

end

