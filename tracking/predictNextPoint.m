function [X,Y] = predictNextPoint(x1,y1,x2,y2)
%x1, y1 is the first point.
%x2, y2 is the second point.

if x1 == x2 && y1 == y2
    X = x1;
    Y = y1;
else
    xDifference = x2-x1;
    slope = (y2-y1)/(xDifference);
    
    b = y1 -slope*x1;
    
    X = xDifference + x2;
    Y = X*slope + b;
    
end


end
