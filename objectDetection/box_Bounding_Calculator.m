function [X_min, X_max, Y_min, Y_max] = box_Bounding_Calculator(X_coord,Y_coord,size_window, image_length, image_width)
size_window = size_window/2;

X_min = X_coord - size_window;
X_max = X_coord + size_window;

Y_min = Y_coord - size_window;
Y_max = Y_coord + size_window;

if X_min < 1
    X_min = 1;
end

if Y_min < 1
    Y_min = 1;
end

if X_max > image_length
    X_max = image_length;
end

if Y_max > image_width
    Y_max = image_width;
end



end