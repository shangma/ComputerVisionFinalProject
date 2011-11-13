%%% Juneki Hong
%%% Computer Vision
%%% Assignment 1
%%% 10/11/11
%%% jhong29@jhu.edu

% Computes the normalized dlt
function [H] = homography_ndlt(X1,X2)

% 1. Get the normalizing matrices
T_n1 = normalizing_matrix(X1);
T_n2 = normalizing_matrix(X2);

% Normalized Coordinates:
x_i1 = T_n1*X1;
x_i2 = T_n2*X2;
    
% 2. Apply DLT algorithm:
H_Rough = homography_dlt(x_i1,x_i2);

% 3. "De-normalize" the Homography
H = inv(T_n2)*H_Rough*T_n1;
H = H/H(3,3);

end

