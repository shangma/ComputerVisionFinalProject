function [ H, T ] = RANSAC_ndlt( m1,m2 )
% m1 and m2 are the corresponding matched points in two images
% H is the best homography using RANSAC for the two images
num = 8;
[null,n] = size(m1); 
X1 = ones(3,num); X2 = ones(3,num);
A = zeros(2,9);

iteration = 0;
while iteration<1000
    index = randi(n,num,1);
    X1(1:2,:) = m1(:,index); X2(1:2,:) = m2(:,index);
    H_tmp = homography_ndlt(X1,X2);
    t = 0;
    for i = 1:n
        x2_tmp = H_tmp*[m1(:,i);1];
        a = cross([m2(:,i);1],x2_tmp);
        d_alg = a(1)^2+a(2)^2;
        if d_alg<10 % asymmetric error
            t = t+1;
            T(t) = i; 
        end
    end
    if t>0.5*n
        break;
    else
        clear T;
    end
    iteration = iteration+1;
end

X1_inliers = ones(3,t); X2_inliers = ones(3,t);
X1_inliers(1:2,:) = m1(:,T); X2_inliers(1:2,:) = m2(:,T);
H = homography_ndlt(X1_inliers,X2_inliers);

end

