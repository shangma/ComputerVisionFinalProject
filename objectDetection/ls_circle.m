%least square method for estimating a Center and radius for a given set of
%points P
function [C,r] = ls_circle(P)
    x = P(1:end,1);
    x = x';
    y = P(1:end,2);
    y = y';
    
    n = length(x);
    xx = x.*x;
    yy = y.*y;
    xy = x.*y;
    A = [sum(x) sum(y) n;sum(xy) sum(yy) sum(y); sum(xx) sum(xy) sum(x)];
    B = [-sum(xx+yy) ; -sum(xx.*y+yy.*y) ; -sum(xx.*x+xy.*y)];
    a = A\B;
    xc = -.5*a(1);
    yc = -.5*a(2);
    C = [xc yc];
    r = sqrt((a(1)^2+a(2)^2)/4-a(3));
end