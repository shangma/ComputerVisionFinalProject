function [n] = white_pixel_counter(IMAGE)
% n = 0;
% 
% for i =1:size(IMAGE,1)
%    for j = 1:size(IMAGE,2)
%       if IMAGE(i,j)
%           n = n+1;
%       end
%    end
% end

n = nnz(IMAGE);

end