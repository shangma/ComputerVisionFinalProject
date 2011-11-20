function [b] = is_adjacent(P1,P2, thresh)
    if (P1(1,1) == P2(1,1)) && (abs(P1(1,2) - P2(1,2)) <= thresh)
        b = 1;
    elseif (P1(1,2) == P2(1,2)) && (abs(P1(1,1) - P2(1,1)) <= thresh)
        b = 1;
    else
        b = 0;
    end
end