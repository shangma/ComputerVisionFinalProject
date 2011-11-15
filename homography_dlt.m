%%% Juneki Hong
%%% Computer Vision
%%% Assignment 1
%%% 10/11/11
%%% jhong29@jhu.edu

% Implements the DLT algorithm.
function [H] = homography_dlt(X1,X2)

% Generate the Ai's to populate the matrix A
A = [];

for i = 1:size(X1,2)
    xip = X2(1,i);
    yip = X2(2,i);
    wip = X2(3,i);
    xi = X1(:,i);
    
    Ai = [ 0, 0, 0,    -wip * xi',   yip * xi' ; ...
        wip * xi',     0, 0, 0,  -xip * xi' ];

    A = [A;Ai];
end

[~,~,V] = svd(A);
h = V(:,9);
H = reshape(h,3,3)';
H = H/H(3,3);

end