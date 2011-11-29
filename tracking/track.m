%F1 = 1 frame ago
%F2 = 2 frames ago
function [] = track(P, thisFrame, thresh)
    [x,y] = size(P);
    predictedFrame = [];
    for i = 1:x
        [predictedFrame(i,1), predictedFrame(i,2)] = predictNextPoint(P(i,1),P(i,2),P(i,3),P(i,4));
        predictedFrame(i,3) = P(i,1);
        predictedFrame(i,4) = P(i,2);
        predictedFrame(i,5) = P(i,3);
        predictedFrame(i,6) = P(i,4);
        
    end
    
    [x,y] = size(thisFrame);
    [x2,y2] = size(predictedFrame);
    found = 0;
    for i = 1:x
        for j = 1:x2
            if pointsCloseEnough(thisFrame(i,1),thisFrame(i,2),predictedFrame(j,1),predictedFrame(j,2),thresh)
                predictedFrame(j,5) = predictedFrame(j,3);
                predictedFrame(j,6) = predictedFrame(j,4);
                predictedFrame(j,3) = thisFrame(i,1);
                predictedFrame(j,4) = thisFarme(i,2);
                found = 1;
            end
        end
        if found == 0
            
        end
    end
end