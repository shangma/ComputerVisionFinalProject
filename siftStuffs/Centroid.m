%%% Juneki Hong
%%% Computer Vision
%%% Assignment 1
%%% 10/11/11
%%% jhong29@jhu.edu

% Computes the centroid of a set of points
function [x,y] = Centroid(X)

numberOfPoints = size(X,2);

sumOfX = sum(X(1,:));
sumOfY = sum(X(2,:));

x = sumOfX/numberOfPoints;
y = sumOfY/numberOfPoints;

end