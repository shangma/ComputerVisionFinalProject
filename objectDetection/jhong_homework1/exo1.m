%%% Juneki Hong
%%% Computer Vision
%%% Assignment 1
%%% 9/10/11
%%% jhong29@jhu.edu

%%
clear all; close all;

%% 1a
lena = imread('lena.jpg');
J = rgb2gray(lena);
figure(1); imshow(J);

%% 1bi
% Method M1
gr2 = g_r(2);
D = im2double(J);
M1 = conv2(D, gr2,'same');
figure(2);imshow(M1);

%% lbii
% Method M2
gh2 = g_h(2);
gv2 = g_v(2);
D = im2double(J);
m1 = conv2(D,gh2,'same');
M2 = conv2(m1,gv2,'same');
figure(3);imshow(M2);

%% 1biii
% Method M3
gh2 = g_h(2);
gv2 = g_v(2);
G = gh2*gv2;

D = im2double(J);
M3 = conv2(D,G,'same');
figure(4);imshow(M3);

%% 1biv
% All three methods produce the exact same image. All three are a little
% blurrier than the original greyscale image, and they look exactly the
% same.

%% 1c
A = e(M1,M2);
B = e(M1,M3);
C = e(M2,M3);

fprintf('mean of the square differences between M1 and M2: %f\n',A);
fprintf('mean of the square differences between M1 and M3: %f\n',B);
fprintf('mean of the square differences between M2 and M3: %f\n',C);

% The images are in fact very similar, and the differences between the
% images are essentially 0

max1 = max_intensity_difference(M1,M2);
max2 = max_intensity_difference(M1,M3);
max3 = max_intensity_difference(M2,M3);

fprintf('maximum intensity between 2 pixels between M1 and M2: %f\n',max1);
fprintf('maximum intensity between 2 pixels between M1 and M3: %f\n',max2);
fprintf('maximum intensity between 2 pixels between M2 and M3: %f\n',max3);

% The images are exactly the same. There are no differences in the
% intensities of the pixels when the filters are applied differently. This
% could be explained because that it doesn't matter whether you apply one
% filter first before the other, or take them at the same time: The result
% will be the same and the resulting images will be the same.



%% 1d

D = im2double(J);

t1 = zeros(1,10);
t2 = zeros(1,10);
for     sigma = 1:10
        tic
        gr2 = g_r(sigma);
        M1 = conv2(D,gr2,'same');
        t1(sigma) = toc;
        tic
        gv2 = g_v(sigma);
        M2 = conv2(D,gv2,'same');
        t2(sigma) = toc;
end
figure(5);
plot(t1);
hold all
plot(t2);
        

%% 1e
% That Method 1 is worse than Method 2. Method 1 starts to really slow down
% as sigma gets larger and larger.

%% 1f
t1 = zeros(1,10);
t2 = zeros(1,10);
D = im2double(J);
M1 = conv2(D, gr2,'same');

for     sigma = 1:10
        tic
        gr2 = g_r(sigma);
        M1 = imfilter(D,gr2);
        t1(sigma) = toc;
        tic
        gh2 = g_h(sigma);
        gv2 = g_v(sigma);
        
        M2 = imfilter(D,gh2);
        M2 = imfilter(D,gv2);
        t2(sigma) = toc;
    
end
figure(6);
plot(t1);
hold all;
plot(t2);



        
%The difference in times in this experiment were much less distinct. It was
%almost negligible. Both experiments ran for almost the same time. 
%The difference is really hard to tell.

%conv2 uses summations to compute its answers while imfilter simply filters
%the array that is given to it. Computationally, the filtering is much
%faster than the summation.



