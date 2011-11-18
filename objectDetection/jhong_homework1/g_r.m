function [h] = g_r(sigma)
h = fspecial('gaussian', [3*sigma,3*sigma], sigma);
end