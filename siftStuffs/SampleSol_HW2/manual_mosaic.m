function [] = manual_mosaic( I1,I2 )
% I1 and I2 are two corresponding images needed to be mosaiced
X1 = ones(3,5);
X2 = ones(3,5);

imshow(I1,[]);
[X,Y] = ginput(5);
X1(1,:) = X'; X1(2,:) = Y';
imshow(I2,[]);
[X,Y] = ginput(5);
X2(1,:) = X'; X2(2,:) = Y';

H = homography_ndlt(X1,X2);
K = blend(I1,I2,H);

imshow(K);

end

