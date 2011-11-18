% RANSAC implementation
% By Roger Xu with slight modifications
function [C,r] = ransac(BW)
    I = edge(BW); 
    [y,x] = find(I); %get a list of all the edge points
    
    n = 3; %Required points for circle
    k = 10000; %iterations
    inlier_threshold = .3; %threshold for determining minimum inliers
    
    C = [];
    r = [];
    
    for i = 1:1:k
        %random indices
        rand1 = ceil(rand*length(x));
        rand2 = ceil(rand*length(x));
        rand3 = ceil(rand*length(x));
        
        P = [x(rand1) y(rand1); x(rand2) y(rand2); x(rand3) y(rand3)]'; %matrix of 3 random points
        [tempC, tempR] = ls_circle(P); %estimated center and radius
        P = [x'; y']; %Get full list of points
        inl = inliers_circle(tempC, tempR, P, 2); %get the points that are inliers
        
        if length(inl) >= (inlier_threshold * 4 * pi * tempR * 2); %if the threshold is met
            x2 = x(inl);
            y2 = y(inl);
            P = [x2' ;y2']; %full list of inlier points
            [tempC, tempR] = ls_circle(P); %get new estimated center and radius
            C = [C; tempC]; %add to output
            r = [r; tempR];
            
            x(inl) = []; %remove inliers from list of points
            y(inl) = [];
        end
    end
end