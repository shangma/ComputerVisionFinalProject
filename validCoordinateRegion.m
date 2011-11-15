function [ valid ] = validCoordinateRegion( x , y )
    if y < 80
        valid = 1;
    else
        valid = 0;
    end
end

