function [result] = pointsCloseEnough(x1,y1,x2,y2,threshold)
%returns true if the two points are close enough (given a threshold)

D = distance(x1,y1,x2,y2);

if D<=threshold
    result = true;
else
    result = false;
    
end


end