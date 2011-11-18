%%% Juneki Hong
%%% Computer Vision
%%% Assignment 1
%%% 9/17/11
%%% jhong29@jhu.edu


%%
clear all; close all;


%% 2a

% See my written assignment for the answer

%% 2b

% See my written assignment for the answer

%% 2c

P = points_circle([0;0],1,100);

figure(1);
plot(P(1,:),P(2,:),'b.');

%% 2d

PN = noisy_points_circle([0;0],1,100,.05);

figure(2);
plot(P(1,:),P(2,:),'b.');
hold on;
plot(PN(1,:),PN(2,:),'r.');

%% 2e

[C,r] =ls_circle(PN);

%% 2f

image = ones([512,512]);
S = points_circle([130,150]',50,10);

X = S(1,:);
Y = S(2,:);

[C,r]= ls_circle(S);
theta = linspace(0,2*pi);

figure(3);
imshow(image);
hold all;
plot(X,Y,'k.');
hold all;
plot(r*cos(theta)+C(1), r*sin(theta)+C(2))


%% 2g

image = ones([512,512]);
S = noisy_points_circle([130,150]',50,10,10);

X = S(1,:);
Y = S(2,:);

[C,r]= ls_circle(S);
theta = linspace(0,2*pi);

figure(4);
imshow(image);
hold all;
plot(X,Y,'k.');
hold all;
plot(r*cos(theta)+C(1), r*sin(theta)+C(2));

%% 2h

%take the image and apply a threshold filter over it. Since there is a
%white background, we can set the threshold really high to get a really
%clear difference (However, if the background wasn't so nice and distinct,
%we could set the threshold lower... but we would suffer from a lot more
%noise). After we pass the threshold, we apply a median filter. This will
%get rid of most of the random "salt and pepper" noise and help us get a
%much more clear distinction.

%After we do all of this, we apply a gradient filter over the image. A
%sharp distinction in the image that we prepared will show up as a clear
%edge. MATLAB convienently has a function called "edge" that will do this
%for us convienently. The end result should be nice clearly defined edges.

coins1 = imread('coins1.jpg');
coins2 = imread('coins2.jpg');

threshold_for_edge = .9;

%threshold filter to make black and white
BW1 = im2bw(coins1,threshold_for_edge);
BW2 = im2bw(coins2,threshold_for_edge);

%median filter to get rid of lots of noise
F1 = medfilt2(BW1);
F2 = medfilt2(BW2);
%figure(12);
%imshow(F);

%gradient filter for edge detection
edge_detected1 = edge(F1,'canny',threshold_for_edge);
edge_detected2 = edge(F2,'canny',threshold_for_edge);

figure(5);
imshow(edge_detected1);
figure(6);
imshow(edge_detected2);


%% 2i

d = 1;
[INL] = inliers_circle(C,r,S,10);

figure(7);
plot(X,Y,'k.');
hold on;
plot(r*cos(theta)+C(1), r*sin(theta)+C(2));
hold on;

for i=1:length(INL)
    index = INL(i);
    x = X(index);
    y = Y(index);
    plot(x,y,'y+');
    hold on;
    
end
% In figure 6:
% The regular black dots represent all of the noisy points for our circle.
% And the blue circle is the corresponding circle that we estimate around
% the black dots.
% The black dots that lie within a distance d within the circle are marked
% with a yellow plus sign (+)
% The black dots in the plot that are still black are the dots that are too
% far away from the circle... and they are not considered inliers. All of
% the other points are considered inliers.

%% 2j

Threshold_for_data1 = .5;
Threshold_for_data2 = .4;
Iterations_to_run = 5000;
samples_to_take = 3;

% RANSAC GOOOOOO!
[X,Y,R] = RANSAC(edge_detected1,Threshold_for_data1,Iterations_to_run,d);


clc;




%% 2k

coins = 0;
N = 100;

figure(8);
imshow(coins1);
hold on;

for i = 1:length(X)
    coins = coins + 1;
    P = points_circle([X(i);Y(i)],R(i),N);
    plot(P(1,:),P(2,:),'b.');
    hold on;
end

% Check the main output for the number of coins found:
fprintf('Number of coins found in coins1.jpg: %i\n',coins);
hold off;


% This almost always finds both coins!!!


%% 2l

[X,Y,R] = RANSAC(edge_detected2,Threshold_for_data2,Iterations_to_run,d);

coins = 0;

figure(9);
imshow(coins2);
hold on;

for i = 1:length(X)
    coins = coins + 1;
    P = points_circle([X(i);Y(i)],R(i),N);
    plot(P(1,:),P(2,:),'b.');
    hold on;
end

% Check the main output for the number of coins found:
fprintf('Number of coins found in coins2.jpg: %i\n',coins);
hold off;


% This usually finds all 8 coins!!!!
% ... Sometimes it only finds 5 though...



%% 2m

% We can use a Hough transform as a different method to count the number of
% coins in the image

