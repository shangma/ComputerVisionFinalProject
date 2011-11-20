I = uint8(imread('../backgroundSubtraction/stable/2.bmp'));
[C,r] = ransac(I);

figure(1); imshow(I);
hold on;
for i = 1:1:length(C)
    x = C(i,1);
    y = C(i,2);
    radius = r(i);
    ang = 0:0.01:2*pi;
    xp = radius*cos(ang);
    yp = radius*sin(ang);
    plot(x+xp,y+yp,'LineWidth',2);
end
hold off;