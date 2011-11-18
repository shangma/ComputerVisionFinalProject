function [X,Y,R] = RANSAC(I,Threshold,Iterations_to_run,d);

% http://en.wikipedia.org/wiki/RANSAC
% Algorithm based off of the wikipedia page:

% I is the image already prepared via edge detection for us to use
% Threshold threshold for how well the data fits the model
% Iterations_to_run iterations for the algorithm to perform
% d what we use to find all the inliers. Inliers are within d distance to
%               the circle

too_small = 5;
too_big = max(length(I));

[yPoints,xPoints] = find(I);
num_edge_points = length(xPoints);

X = [];
Y = [];
R = [];

for i = 1:Iterations_to_run
    
    if num_edge_points<=0
        break;
    end
    
    lol1 = randi(num_edge_points);
    lol2 = randi(num_edge_points);
    lol3 = randi(num_edge_points);
    points = [lol1;lol2;lol3];
    Xpoints = xPoints(points).';
    Ypoints = yPoints(points).';
    
    [C,r] = ls_circle([Ypoints;Xpoints]);
    y_center = C(1);
    x_center = C(2);
    
    if r > too_big || r < too_small || x_center > size(I,1) || x_center < 1 || y_center > size(I,2) || y_center < 1 
        continue;
    end;
    
    r_d = sqrt((yPoints - y_center).^2 + (xPoints - x_center).^2);
    inliers = find((r_d>r-d)&(r_d<r+d));
    
    [C,r] = ls_circle([yPoints(inliers).';xPoints(inliers).']);
    
    if length(inliers)<Threshold*4*pi*r*d || length(inliers)<3,
        continue;
    end;
    
    
    X = [X C(2)];
    Y = [Y C(1)];
    R = [R r];
    
    yPoints(inliers) = [];
    xPoints(inliers) = [];
    num_edge_points = length(xPoints);
    
end
end
