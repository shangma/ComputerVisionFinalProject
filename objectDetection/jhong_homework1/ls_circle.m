
function [C,r] = ls_circle(P)
    P = P';
    P(:,3) = 1;

    B = -(P(:,1).^2 + P(:,2).^2);

    V = pinv(P)*B;
    C = -V(1:2)/2;
    r = sqrt(-V(3) + sum(C.^2));
    
    
end