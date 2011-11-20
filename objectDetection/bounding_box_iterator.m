function [M] = bounding_box_iterator(IMAGE, size_window, white_pixel_threshold)

size_window = round(size_window);

M = [];
image_length = size(IMAGE,1);
image_width = size(IMAGE,2);

%white_pixel_threshold = size_window*size_window/2;

offset_skip = round(size_window/4);

for i=1:(offset_skip):image_length
   for j=1:(offset_skip):image_width 
       
       [X_min, X_max, Y_min, Y_max] = box_Bounding_Calculator(i,j,size_window,image_length,image_width);
       subImage = IMAGE(X_min:X_max,Y_min:Y_max);
       
       white_pixels = white_pixel_counter(subImage);
       
       if white_pixels > white_pixel_threshold
           M = [M ; i j size_window];
       end
       
       
   end
end


 
end

