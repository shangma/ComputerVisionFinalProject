% My simple euclidian distance function. It is used in
% match_corners_NCC_modified

function [r] = euclidian_distance(x1,y1,x2,y2)
if x1 == x2 & y1 == y2
    r = 1;
else
    r = sqrt((x1-x2)^2 + (y1-y2)^2);
    
    if r<1
        r =1;
    end
end

end


% It avoids dividing by zero if the two points given to me are exactly the
% same