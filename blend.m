function [ K ] = blend( I1,I2,H )

% Set the alpha for color blending
alpha = 0.9;

% Calculate the width and height of the image
[height width ~] = size(I1);

% Calculate the size of the mesh grid
[grid_x,grid_y] = meshgrid(1:720,1:480);

% Calculate x,y,z,w
x = (H(1,1)*grid_x+H(1,2)*grid_y+H(1,3));
y = (H(2,1)*grid_x+H(2,2)*grid_y+H(2,3));
z = (H(3,1)*grid_x+H(3,2)*grid_y+H(3,3));
w = 1./z;

% Run the bilinear interpolation
mosaic(:,:,1) = interp2(I2(:,:,1), x.*w,y.*w, '*bilinear');
mosaic(:,:,2) = interp2(I2(:,:,2), x.*w,y.*w, '*bilinear');
mosaic(:,:,3) = interp2(I2(:,:,3), x.*w,y.*w, '*bilinear');

% Set all the null values to 0 (BLACK)
mosaic(isnan(mosaic)) = 0;

% Iterate over the image and apply the color blending.
% for i=1:height
%     for j=1:width
%         if sum(mosaic(i,j,:) > 0)
%             mosaic(i,j,:) = alpha*mosaic(i,j,:) + (1-alpha)*I1(i,j,:);
%         else
%             mosaic(i,j,:) = I1(i,j,:);
%         end
%     end
% end

% Set the mosaic as the return value (K)
K = mosaic;

end

