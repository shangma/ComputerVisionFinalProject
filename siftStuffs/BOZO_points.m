%%% Juneki Hong
%%% Computer Vision
%%% Assignment 1
%%% 10/11/11
%%% jhong29@jhu.edu

% I needed some random unique points. So I made this function
function [p1, p2, p3, p4] = BOZO_points(n)

if n<4
   error('what is this I dont even'); 
end

p1 = randi(n);
p2 = randi(n);
p3 = randi(n);
p4 = randi(n);

if p1 == p2 || p1 == p3 || p1 == p4 || p2 == p3 || p2 == p4 || p3 == p4
    [p1,p2,p3,p4] = BOZO_points(n);
end
end