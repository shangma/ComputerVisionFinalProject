%%% Juneki Hong
%%% Computer Vision
%%% Assignment 1
%%% 10/11/11
%%% jhong29@jhu.edu

% Uses RANSAC to come up with the appropriate H
function [H] = RANSAC_ndlt(m1,m2)

% Iterations
k= 10;

% Default Homography H. We'll change it later in the code.
H = ones(3,3);

% Votes
maxVote = 0;

% The threshold to use
threshold=5;

% Number of points in m1
n = size(m1,2);

for i = 0:k
    
    clear inliers_tentative;
    
    % 4 random numbers from 1 to N
    [p1,p2,p3,p4] = BOZO_points(n);

    % Set of points to use
    X1 = [m1(:,p1) m1(:,p2) m1(:,p3) m1(:,p4) ; ones(1,4)];
    X2 = [m2(:,p1) m2(:,p2) m2(:,p3) m2(:,p4) ; ones(1,4)];

    H_tentative = homography_ndlt(X1,X2);

    % Every time we get an "inlier", we increase the number of votes.
    vote=0;
    for count=1:length(m1)
        x1 = m1(1,count);
        y1 = m1(2,count);
        
        X_prime=H_tentative*[x1;y1;1];
        x3=X_prime(1);
        y3=X_prime(2);
        z3=X_prime(3);

        x3=x3/z3;
        y3=y3/z3;

        x2=m2(1,count);
        y2=m2(2,count);   
                
        if ((x2-x3)^2+(y2-y3)^2 <= threshold^2)
            vote=vote+1;
        end
    end

    % If we have enough votes, we will keep this configuration as the
    % possible H to return
    if vote>maxVote
        maxVote=vote;
        H=H_tentative;
    end

end

end