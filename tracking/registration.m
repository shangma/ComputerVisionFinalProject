function [detected, registered, tracked]=registration(detected,registered,tracked)

THRESHOLD = 10;


%registered is a matrix that is Nx5
% x1 y1 x2 y2 boundingbox1 boundingbox2 boundingbox3 boundingbox4 count

newRegistered = [];


i = 1;
while i<=size(detected,1) && size(detected,2) > 0
    %for i=1:size(detected,1) %iterates over the detected objects
    %detectedCoordinateX = detected(i,1);
    %detectedCoordinateY = detected(i,2);
    detectedCoordinates = detected(i).Centroid;
    dY = detectedCoordinates(1);
    dX = detectedCoordinates(2);
    
    boundingBox = detected(i).BoundingBox;
    
    
    minDistanceValue = THRESHOLD + 1;
    
    
    j = 1;
    while j<= size(registered,1)
        %for j = 1:size(registered,1) %iterates over the registered objects
        rX = registered(j,1);
        rY = registered(j,2);
        
        %if j == 1
        %    minDistanceValue = distance(dX,dY,rX,rY);
        %    minDistanceIndex = j;
        %else
        tempDistance = distance(dX,dY,rX,rY);
        
        if minDistanceValue > tempDistance
            minDistanceValue = tempDistance;
            minDistanceIndex = j;
            
        end
        
        %end
        j = j+1;
    end
    
    if minDistanceValue <= THRESHOLD
        %we have a match!
        detected(i) = [];
        i = i-1;
        
        %we have to update the registered object
        registered(minDistanceIndex,9) = registered(minDistanceIndex,9) + 2;
        
        registered(minDistanceIndex,4) = registered(minDistanceIndex,2);
        registered(minDistanceIndex,3) = registered(minDistanceIndex,1);
        
        registered(minDistanceIndex,1) = dX;
        registered(minDistanceIndex,2) = dY;
        
    else
        %we dont have a match...
        
        %begin registering the object. Add it to registered with count 2
        newRegistered = [newRegistered; dX dY -1 -1 boundingBox(1) boundingBox(2) boundingBox(3) boundingBox(4) 1];
        
        detected(i) = [];
        i = i-1;
        
    end
    
    i = i+1;
end




k = 1;
while k<=size(registered,1)
    %for k =1:size(registered,2)
    
    %decrement every registered by 1
    registered(k,9) = registered(k,9)-1;
    
    if registered(k,9) <= 0
        registered = deleteEntry(registered,k);
        k = k-1;
        
    else
        if registered(k,9) == 3
            %add it to tracked
              
            tracked = [tracked ; registered(k,1:8)];
            registered = deleteEntry(registered,k);
            k = k-1;
        end
    end
    
    k = k+1;
end

registered = [registered; newRegistered];

end




