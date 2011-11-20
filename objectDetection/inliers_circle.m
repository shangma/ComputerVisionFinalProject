function [inl] = inliers_circle(C,r,P,d)
    x = length(P);
    inl = [];
    for i = 1:1:x
       a = (C(1) - P(i,1))^2;
       b = (C(2) - P(i,2))^2;
       c = sqrt(a+b);
       if abs(c-r) <= d
           inl = [inl i];
       end
    end
end