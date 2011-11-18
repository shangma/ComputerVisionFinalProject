%%% Juneki Hong
%%% Computer Vision
%%% Assignment 1
%%% 9/18/11
%%% jhong29@jhu.edu


%%
clear; close all;


%% 3a
building1 = imread('building1.bmp');
building2 = imread('building2.bmp');


building1 = rgb2gray(building1);
building2 = rgb2gray(building2);

building1 = im2double(building1);
building2 = im2double(building2);

[D1] = harrisCorner(building1);
[D2] = harrisCorner(building2);

X1 = D1(2,:);
Y1 = D1(1,:);

X2 = D2(2,:);
Y2 = D2(1,:);

figure(1);
imshow(building1);
hold on;
plot(X1,Y1,'w.');

figure(2);
imshow(building2);
hold on;
plot(X2,Y2,'w.');

%% 3b

%This is my NCC corner matching algorithm.

ws = 40;
[m1,m2] = match_corners_NCC(building1,building2,[X1;Y1],[X2;Y2],ws);


%% 3c

I = [building1,building2];
figure(3);
imshow(I);
hold on;

m1 = m1';
m2 = m2';
hold on;
plot(m1(1,:),m1(2,:),'w.');
hold on;
plot(m2(1,:)+size(building1,2), m2(2,:),'w.');
hold on;


for i=1:size(m1,2)
    LINE = line([m1(1,i);m2(1,i)+size(building1,2)],[m1(2,i);m2(2,i)]);
    hold on;
    plot(LINE);
end

% Hey. It draws lines between both images!



%% 3d

% The modified NCC match corners function just divides by the euclidian
% distances to give heavier weights to points nearby versus points further
% away. 

[m1,m2] = match_corners_NCC_modified(building1,building2,[X1;Y1],[X2;Y2],ws);


figure(4);
imshow(I);
hold on;

m1 = m1';
m2 = m2';
hold on;
plot(m1(1,:),m1(2,:),'w.');
hold on;
plot(m2(1,:)+size(building1,2), m2(2,:),'w.');
hold on;


for i=1:size(m1,2)
    LINE = line([m1(1,i);m2(1,i)+size(building1,2)],[m1(2,i);m2(2,i)]);
    hold on;
    plot(LINE);
end


% HOLY CRAP THIS WORKS. I AM SO HAPPY. :D
% THIS IS SO AWESOME.


