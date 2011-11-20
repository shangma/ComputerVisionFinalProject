function [IMAGE] = detected_object_eraser(IMAGE,M)


image_length = size(IMAGE,1);
image_width = size(IMAGE,2);

for i=1:length(M)
    xValue = round(M(i,1));
    yValue = round(M(i,2));
    windowSize = round(M(i,3));
    
    [X_min, X_max, Y_min, Y_max] = box_Bounding_Calculator(xValue,yValue,windowSize, image_length, image_width);
    IMAGE(X_min:X_max,Y_min:Y_max) = 0;
    
end

end