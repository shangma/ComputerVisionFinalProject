function [detected,tracked] = tracked(detected,tracked,realFrame)

THRESHOLD = 10;

% for i = 1 : size(tracked,1)
%    if tracked(i,9) > 0
%        
%    end
% end

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
        taxi_mean_r = 127;
        taxi_mean_g = 132;
        taxi_mean_b = 111;
        taxi_std_r = 13;
        taxi_std_g = 12;
        taxi_std_b = 12;
        
        car_mean_r = 145;
        car_mean_g = 150;
        car_mean_b = 158;
        car_std_r = 17;
        car_std_g = 15;
        car_std_b = 14;
        
        bike_mean_r = 106;
        bike_mean_g = 111;
        bike_mean_b = 122;
        bike_std_r = 12;
        bike_std_g = 13;
        bike_std_b = 13;
        
        radius_x = floor(trackedPoint(7)/2);
        radius_y = floor(trackedPoint(8)/2);
        
        bottomRightX = predictedX + radius_x;
        bottomRightY = predictedY + radius_y;
        
        for a = 1 : 3
            for b = 1 : 3
                centerX = bottomRightX - (a-1)*radius_x;
                centerY = bottomRightY - (a-1)*radius_y;
                top_left_x = centerX - radius_x;
                top_left_y = centerY - radius_y;
                bottom_left_y = centerY + radius_y;
                top_right_x = centerX + radius_x;
                
                if (top_left_x > 0) && (top_right_x < 720) && (top_left_y > 0) && (bottom_left_y < 480)
                    temp = realFrame(top_left_y:bottom_left_y,top_left_x:top_right_x,:);
                    
                    [r,g,b] = rgb_mean(temp);
                    num_std = 1.5;
                    
                    tracked(i,1) = predictedX;
                    tracked(i,2) = predictedY;
                    
                    if tracked(i,9) == 1 && abs(taxi_mean_r-r) < num_std*taxi_std_r && abs(taxi_mean_g-g) < num_std*taxi_std_g && abs(taxi_mean_b-b) < num_std*taxi_std_b
                        tracked(i,3) = tracked(i,1);
                        tracked(i,4) = tracked(i,2);
                        %disp('Tracked');
                        break;
                    elseif tracked(i,9) == 2 && abs(car_mean_r-r) < num_std*car_std_r && abs(car_mean_g-g) < num_std*car_std_g && abs(car_mean_b-b) < num_std*car_std_b
                        tracked(i,3) = tracked(i,1);
                        tracked(i,4) = tracked(i,2);
                        %disp('Tracked');
                        break;
                    elseif tracked(i,9) == 3 && abs(bike_mean_r-r) < num_std*bike_std_r && abs(bike_mean_g-g) < num_std*bike_std_g && abs(bike_mean_b-b) < num_std*bike_std_b
                        tracked(i,3) = tracked(i,1);
                        tracked(i,4) = tracked(i,2);
                        %disp('Tracked');
                        break;
                    else
                        tracked(i,:) = [-1 -1 -1 -1 -1 -1 -1 -1 -1];
                    end
                else
                    tracked(i,:) = [-1 -1 -1 -1 -1 -1 -1 -1 -1];
                end
            end
        end
    end
    
    i = i+1;
    
end

end
