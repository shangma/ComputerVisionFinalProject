
function [INL] = inliers_circle(C,r,P,d)
    inR = r-d;
    outR = r+d;
    
    normX = P(1,:) - C(1);
    normY = P(2,:) - C(2);
    
    PRadius = sqrt(normX.^2 + normY.^2);

    INL = 1:length(P);
    INL = INL((PRadius<outR) & (PRadius>inR));
    
end