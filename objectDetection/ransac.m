% RANSAC implementation
% By Roger Xu with slight modifications
function [C,r] = ransac(BW)
    [sizeX, sizeY] = size(BW);
    
    x = [];
    y = [];
    
    for i = 1:1:sizeX
       for j = 1:1:sizeY
           if BW(i,j) > 0
               x = [x; i];
               y = [y; j];
           end
       end
    end
    
%     I = edge(BW);
%     [y,x] = find(I); %get a list of all the edge points

    k = 10000; %iterations
    
    C = [];
    r = [];
    
    for i = 1:1:k
        %random indices
        rand1 = ceil(rand*length(x));
        rand2 = ceil(rand*length(x));
        rand3 = ceil(rand*length(x));
        
        P = [x(rand1) y(rand1); x(rand2) y(rand2); x(rand3) y(rand3)]'; %matrix of 3 random points
        [tempC, tempR] = ls_circle(P); %estimated center and radius
        P = [x y]; %Get full list of points
        inl = inliers_circle(tempC, tempR, P, 2); %get the points that are inliers
        
        
        %if length(inl) >= (inlier_threshold * pi * tempR); %if the threshold is met
        if tempR <= 15
            x2 = x(inl);
            y2 = y(inl);
            P = [x2 y2]; %full list of inlier points
            try
                [tempC, tempR] = ls_circle(P); %get new estimated center and radius
            catch err
            end
            C = [C; tempC];
            r = [r; tempR];
            
            x(inl) = []; %remove inliers from list of points
            y(inl) = [];
        end
    end
end