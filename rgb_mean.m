function [R,G,B] = rgb_mean(I)

R = mean(mean(I(:,:,1)));
G = mean(mean(I(:,:,2)));
B = mean(mean(I(:,:,3)));

end
