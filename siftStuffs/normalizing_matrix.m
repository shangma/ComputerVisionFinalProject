%%% Juneki Hong
%%% Computer Vision
%%% Assignment 1
%%% 10/11/11
%%% jhong29@jhu.edu

% Computes the matrix that will normalize a set of points
function T_n = normalizing_matrix(X)

% i. Calculate Centroid:
[Cx,Cy] = Centroid(X);

% ii. Center all the points by subtracting by the Centroid:
X_Centered = [X(1,:) - Cx; X(2,:) - Cy; X(3,:)];

% iii. Get all the distances for all the points:
X_Distances = sqrt((X_Centered(1,:).^2) + (X_Centered(2,:).^2));

% iv. Sum them together and divide by n (number of points):
D_avg = sum(X_Distances)/size(X_Distances,2);

% v. Find the ratio to average by:
Ratio_avg = D_avg/sqrt(2);

% vii. Produce the Normalized Points:
%X_Normalized = [X(1,:)./Ratio_avg; X(2,:)./Ratio_avg; X(3,:)];

% Normalizing matrices:
T_n = [1/Ratio_avg 0 (-Cx/Ratio_avg); 0 1/Ratio_avg (-Cy/Ratio_avg); 0 0 1];

end