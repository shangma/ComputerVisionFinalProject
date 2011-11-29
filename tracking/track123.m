function [detected,tracked] = track123(detected,tracked)

THRESHOLD = 10;

i = 1;

while i< size(tracked,1)
    trackedPoint = tracked(i,:);
    [predictedX,predictedY]=predictNextPoint(trackedPoint(3),trackedPoint(4),trackedPoint(1),trackedPoint(2));
    
    minDistanceValue = THRESHOLD + 1;
    
    j = 1;
    while j< size(detected,1) && size(detected,2) > 0
        detectedPoint = detected(j);
        dX = detectedPoint.Centroid(2);
        dY = detectedPoint.Centroid(1);
        
        tempDistance = distance(dX,dY,predictedX,predictedY);
        
        if minDistanceValue > tempDistance
            minDistanceValue = tempDistance;
            minDistanceIndex = j;
            
        end
        
        
        j = j+1;
    end
    
    if minDistanceValue <= THRESHOLD
        %a detected object is really close to this predicted point!
        tracked(i,3) = tracked(i,1);
        tracked(i,4) = tracked(i,2);
        
        tracked(i,2) = detected(minDistanceIndex).Centroid(1);
        tracked(i,1) = detected(minDistanceIndex).Centroid(2);
        
        detected(minDistanceIndex) = [];
        
    else
        %if no detected objects are close...
        
        
        
        %if we dont, delete the tracked object...
        tracked(i,:) = [];
        i = i-1;
        
    end
    
    
    
    i = i+1;
    
end



end






%
%
%
% %F1 = 1 frame ago
% %F2 = 2 frames ago
% function [] = track(P, thisFrame, thresh)
%     [x,y] = size(P);
%     predictedFrame = [];
%     for i = 1:x
%         [predictedFrame(i,1), predictedFrame(i,2)] = predictNextPoint(P(i,1),P(i,2),P(i,3),P(i,4));
%         predictedFrame(i,3) = P(i,1);
%         predictedFrame(i,4) = P(i,2);
%         predictedFrame(i,5) = P(i,3);
%         predictedFrame(i,6) = P(i,4);
%
%     end
%
%     [x,y] = size(thisFrame);
%     [x2,y2] = size(predictedFrame);
%     found = 0;
%     for i = 1:x
%         for j = 1:x2
%             if pointsCloseEnough(thisFrame(i,1),thisFrame(i,2),predictedFrame(j,1),predictedFrame(j,2),thresh)
%                 predictedFrame(j,5) = predictedFrame(j,3);
%                 predictedFrame(j,6) = predictedFrame(j,4);
%                 predictedFrame(j,3) = thisFrame(i,1);
%                 predictedFrame(j,4) = thisFarme(i,2);
%                 found = 1;
%             end
%         end
%         if found == 0
%
%         end
%     end
% end