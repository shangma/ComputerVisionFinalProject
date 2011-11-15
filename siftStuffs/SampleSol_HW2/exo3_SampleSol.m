%%% Computer Vision Class, Fall 2011, Johns Hopkins University
%%% Assignment 2, Exercise 3
%%% This is a sample solution (adapted from Menghan Jin)

%% Image mosaicing

%% a. Explain how to compute normalization matrix in DLT algorithm
% The normalization matrix should make the centroid of the correspondence
% points to origin(0,0) and the average distances are sqrt(2). Let u1 be
% the average of x and u2 be the average of y, then (u1,u2) is the centroid
% of the point pairs. Let c1 be the average distance to u1 on x and c2 be the
% average distance to u2 on y, then we can have a matrix T, which is
% represented as [s1 0 t1;0 s2 t2;0 0 1], where s1=1/c1,s2=1/c2,t1=-u1/c1,
% t2=-u2/c2

%% b. Implement a function homography_ndlt(X1,X2)
H = homography_ndlt( X1,X2 );

%% c. Implement a function blend(I1,I2,H)
blend(I1,I2,H);

%% d. Implement a function manual_mosaic using previous two functions
% In order to make this function work, the user needs to click 5
% corresponding points for each image.

%% f. Using SIFT features
% i. Display the positions of the features in the two images
I1 = imread('hopkins1.jpg'); I2 = imread('hopkins2.jpg');
S = load('sift_hopkins','-mat');
p1 = S.SIFT_P1; p2 = S.SIFT_P2; d1 = S.SIFT_D1; d2 = S.SIFT_D2;

imshow(I1,[]);hold on
plot(p1(1,:),p1(2,:),'*'); hold off;
figure;
imshow(I2,[]);hold on
plot(p2(1,:),p2(2,:),'*'); hold off;

% ii. Implement function sift_matcher(p1,p2,d1,d2) to find matching feature
[m1 m2] = sift_matcher(p1,p2,d1,d2);

% iii. Display two images side by side within one figure and draw lines
[r,c,null] = size(I1);
Z = ones(r, 2*c+5,3);
Z(:,1:c,:) = I1;Z(:,c+6:2*c+5,:) = I2;
figure;
imshow(uint8(Z),[]);
hold on;
plot(m1(1,:),m1(2,:),'o');
plot(m2(1,:)+6+c,m2(2,:),'o');
for i = 1:length(m1)
    line([m1(1,i),m2(1,i)+c+6],[m1(2,i),m2(2,i)],'LineWidth',1,'Color','r');
end
hold off;

%% g. Implement a function uses RANSAC
% i. Compute the best homography using RANSAC
% ii. Display the two images and show inliers in previous question
[H,T] = RANSAC_ndlt( m1,m2 );
num_inliers = length(T);
p1_inliers = m1(:,T); p2_inliers = m2(:,T);
figure;
imshow(uint8(Z),[]);
hold on;
plot(p1_inliers(1,:),p1_inliers(2,:),'o');
plot(p2_inliers(1,:)+6+c,p2_inliers(2,:),'o');

% iii. Implement a function using RANSAC to mosaic two images
auto_mosaic( I1,I2,p1,p2,d1,d2 );

