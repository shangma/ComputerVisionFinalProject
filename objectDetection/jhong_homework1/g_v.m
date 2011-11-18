function [h] = g_v(sigma)
h = fspecial('gaussian', [1,3*sigma], sigma);
end
