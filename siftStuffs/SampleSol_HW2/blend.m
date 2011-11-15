function [ K ] = blend( I1,I2,H )
% K is the new image of the blend
% I1 and I2 are the two images needed to be warped
% H is the homography between them

[m1 n1 null] = size(I1); [m2 n2 null] = size(I2);
% Find the corresponding postitions of the four corners of I2 in I1
H_inv = inv(H);
cornerUL = H_inv*[1 1 1]'; cornerUR = H_inv*[n2 1 1]';
cornerDL = H_inv*[1 m2 1]'; cornerDR = H_inv*[n2 m2 1]';
X = ceil([cornerUL(1)/cornerUL(3),cornerUR(1)/cornerUR(3),cornerDL(1)/cornerDL(3),cornerDR(1)/cornerDR(3)]);
Y = ceil([cornerUL(2)/cornerUL(3),cornerUR(2)/cornerUR(3),cornerDL(2)/cornerDL(3),cornerDR(2)/cornerDR(3)]);
n = max(X); m = max(Y) - min(Y);
y_shift = min(min(Y),0); x_shift = min(min(X),0); % Warped image might go outside current coordinates.
% I1 is duplicated in the new image mosaic
mosaic = zeros(max(m,m1),max(n,n1),3);
mosaic(-y_shift+1:-y_shift+m1,1:n1,:) = I1;
% Compute the corresponding locations of each warped point in original
% image I2
XI = zeros(max(m,m1),max(n,n1)-min(X)+1); YI = zeros(max(m,m1),max(n,n1)-min(X)+1);
for i = min(X):max(n,n1)
    for j = 1:max(m,m1)
        p_dst = [i,j+y_shift,1]';
        p_src = H*p_dst;
        XI(j,i-min(X)+1) = p_src(1)/p_src(3); YI(j,i-min(X)+1) = p_src(2)/p_src(3);
    end
end
% Interpolate using those points locations to get the warped image
for k = 1:3
    mosaic(1:max(m,m1),min(X):max(n,n1),k) = interp2(1:n1,1:m1,double(I2(:,:,k)),XI,YI,'linear');
end
% For overlapping region, use the mean of two pixels as final color
for i = min(X):n1
    for j = -y_shift+1:-y_shift+m1
        if sum(uint8(mosaic(j,i,:)))==0 % black pixel, no averaging
            for k = 1:3
                mosaic(j,i,k) = I1(j+y_shift,i,k);
            end
        else
            for k = 1:3
                mosaic(j,i,k) = (double(I1(j+y_shift,i,k))+mosaic(j,i,k))/2;
            end
        end
    end
end
K = uint8(mosaic);

end

