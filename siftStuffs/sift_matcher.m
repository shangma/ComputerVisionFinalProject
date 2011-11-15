%%% Juneki Hong
%%% Computer Vision
%%% Assignment 2
%%% 10/11/11
%%% jhong29@jhu.edu

% Does sift matching
function [m1,m2] = sift_matcher(p1,p2,d1,d2)

% Initialize empty m1 and m2 and then populate them as we run
m1 = [];
m2 = [];

% We don't want to see every single match, because it makes everything
% cluttered. So we set a threshold as a filter. 
threshold = 100;

% Outer loop. Iterates over each descriptor in the first image
for i=1:size(d1,2)
    minimumDistance = Inf;
    winningIndex = 0;
    descriptors1 = double(d1(:,i));
    
    % Inner loop. Iterates over each descriptor in the second image to
    % compare with the descriptors in the first image
    for j=1:size(d2,2)
        descriptors2 = double(d2(:,j));
        distance = norm(descriptors1-descriptors2);

        % We maintain a minimum distance. Because the smallest distance is
        % like the best match
        if distance < minimumDistance
            winningIndex = j;
            minimumDistance = distance;
        end        
    end
    
    % Filter out a bunch of lines. Only take the best matches.
    if minimumDistance < threshold
        m1 = horzcat(m1,p1(:,i));
        m2 = horzcat(m2,p2(:,winningIndex));
    end
end

end
