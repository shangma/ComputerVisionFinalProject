function [P] = best_point(M)
    sumY = 0;
    sumX = 0;
    
    [xM, yM] = size(M);
    for i = 1:xM 
        sumY = sumY + M(i,1);
        sumX = sumX + M(i,2);
    end
    sumY = sumY / xM;
    sumX = sumX / xM;
    P = [sumY sumX];
end