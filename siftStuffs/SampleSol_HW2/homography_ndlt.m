function [ H ] = homography_ndlt( X1,X2 )
% H is the resulting homography matrix between X1 and X2
% X1 and X2 are corresponding points vector in homogeneous coordinate

[m n]  = size(X1);
T1 = zeros(3,3); T2 = zeros(3,3);
u1 = sum(X1(1,:))/n; u2 = sum(X1(2,:))/n;
d = sum(sqrt((X1(1,:)-u1).^2+(X1(2,:)-u2).^2))/n;
T1(1,1) = sqrt(2)/d; T1(2,2) = sqrt(2)/d; T1(1,3) = -sqrt(2)/d*u1; T1(2,3) = -sqrt(2)/d*u2;T1(3,3)=1;
u1 = sum(X2(1,:))/n; u2 = sum(X2(2,:))/n;
d = sum(sqrt((X2(1,:)-u1).^2+(X2(2,:)-u2).^2))/n;
T2(1,1) = sqrt(2)/d; T2(2,2) = sqrt(2)/d; T2(1,3) = -sqrt(2)/d*u1; T2(2,3) = -sqrt(2)/d*u2;T2(3,3)=1;
X1_norm = T1*X1; X2_norm = T2*X2; % X1_norm(3,:)=X2_norm(3,:)=1

A = zeros(2*n,9);
for i = 1:n
    A((i-1)*2+1,:) = [0,0,0,X1_norm(1,i),X1_norm(2,i),1,-X2_norm(2,i)*X1_norm(1,i),-X2_norm(2,i)*X1_norm(2,i),-X2_norm(2,i)];
    A((i-1)*2+2,:) = [X1_norm(1,i),X1_norm(2,i),1,0,0,0,-X2_norm(1,i)*X1_norm(1,i),-X2_norm(1,i)*X1_norm(2,i),-X2_norm(1,i)];
end
[U,S,V] = svd(A);
h = V(:,end);
H = [h(1) h(2) h(3);h(4) h(5) h(6);h(7) h(8) h(9)];
H = inv(T2)*H*T1;

end

