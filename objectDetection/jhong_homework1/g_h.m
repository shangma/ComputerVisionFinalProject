
function  [h] = g_h(sigma)
h = fspecial('gaussian', [3*sigma,1], sigma);
end