function [P] = best_point(M)
    sumY = 0;
    sumX = 0;
    
    [xM, yM] = size(M);
    
    sumY = sum(M(1:xM,1));
    sumX = sum(M(1:xM,2));
    
%     for i = 1:xM 
%         sumY = sumY + M(i,1);
%         sumX = sumX + M(i,2);
%     end
    sumY = round(sumY / xM);
    sumX = round(sumX / xM);
    P = [sumY sumX];
end