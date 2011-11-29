realObj = mmreader('../backgroundSubtraction/real.avi');
trafficObj = mmreader('../backgroundSubtraction/approximate_median_background.avi');

filterValue = 10;
sedisk = strel('disk',2);

nframes = get(trafficObj, 'NumberOfFrames');
I = read(trafficObj, 1);
%taggedCars = zeros([size(I,1) size(I,2) 3 nframes], class(I));
taggedCars = zeros([480 720 3 nframes], class(I));

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

registration_data = [];
tracking_data = [];

% for k = 1 : nframes
for k = 1 : nframes
    singleFrame = read(trafficObj, k);
    realFrame = read(realObj, k);
    I = rgb2gray(singleFrame);
    
    %real = imread(sprintf('stable/%d.bmp',k));s
    %imshow(realFrame);
    %filtered = imextendedmax(I, filterValue);
    
    filtered = imopen(I, sedisk);
    filtered = bwareaopen(filtered, 200);
    
    L = bwlabel(filtered);
    
    %real = im2frame(uint8(real),gray(256));
    
    %try
    taggedCars(:,:,:,k) = realFrame; %singleFrame;
    
    if any(L(:))
        stats = regionprops(L, {'centroid','area','BoundingBox'});
        stats2 = stats;
        [stats2 tracking_data] = tracked(stats2,tracking_data);
        [stats2 registration_data tracking_data] = registration(stats2,registration_data, tracking_data);
        
        for q = 1 : size(tracking_data,1)
            stats2(q).BoundingBox = [tracking_data(q,5:8)];
            stats2(q).Centroid = [tracking_data(q,2) tracking_data(q,1)];
        end
        
        stats = stats2;
        
        for z = 1 : length(stats)
            idx = z;
            c = stats(idx).Centroid;
            c = floor(fliplr(c));
            [width] = stats(idx).BoundingBox;
            radius_x = floor(width(3)/2);
            radius_y = floor(width(4)/2);
            
            top_left_x = c(2) - radius_x;
            top_left_y = c(1) - radius_y;
            bottom_left_x = c(2) - radius_x;
            bottom_left_y = c(1) + radius_y;
            top_right_x = c(2) + radius_x;
            top_right_y = c(1) - radius_y;
            bottom_right_x = c(2) + radius_x;
            bottom_right_y = c(1) + radius_y;
            
            if (top_left_x > 0) && (top_right_x < 720) && (top_left_y > 0) && (bottom_left_y < 480)
                border=0;
                temp1 = realFrame(top_left_y:bottom_left_y,top_left_x:top_right_x,:);
                temp2 = filtered(top_left_y:bottom_left_y,top_left_x:top_right_x);
                
                temp3 = zeros(size(temp1));
                temp3(:,:,1) = double(temp1(:,:,1)) .* double(temp2);
                temp3(:,:,2) = double(temp1(:,:,2)) .* double(temp2);
                temp3(:,:,3) = double(temp1(:,:,3)) .* double(temp2);
                
                [r,g,b] = rgb_mean(temp1);
                
                num_std = 1.3;
                
                if tracking_data(idx,9) == -1
                    if abs(taxi_mean_r-r) < num_std*taxi_std_r && abs(taxi_mean_g-g) < num_std*taxi_std_g && abs(taxi_mean_b-b) < num_std*taxi_std_b
                        tracking_data(idx,9) = 1;
                    elseif abs(car_mean_r-r) < num_std*car_std_r && abs(car_mean_g-g) < num_std*car_std_g && abs(car_mean_b-b) < num_std*car_std_b
                        tracking_data(idx,9) = 2;
                    elseif abs(bike_mean_r-r) < num_std*bike_std_r && abs(bike_mean_g-g) < num_std*bike_std_g && abs(bike_mean_b-b) < num_std*bike_std_b
                        tracking_data(idx,9) = 3;
                    else
                        tracking_data(idx,9) = 4;
                    end
                end
                
                if tracking_data(idx,9) == 1
                    value1 = 255;
                    value2 = 255;
                    value3 = 0;
                elseif tracking_data(idx,9) == 2
                    value1 = 255;
                    value2 = 255;
                    value3 = 255;
                elseif tracking_data(idx,9) == 3
                    value1 = 0;
                    value2 = 0;
                    value3 = 0;
                elseif tracking_data(idx,9) == 4
                    value1 = 255;
                    value2 = 0;
                    value3 = 0;
                end
                
                
                taggedCars(top_left_y,top_left_x:top_right_x,1,k) = value1;
                taggedCars(top_left_y,top_left_x:top_right_x,2,k) = value2;
                taggedCars(top_left_y,top_left_x:top_right_x,3,k) = value3;
                
                taggedCars(bottom_left_y,bottom_left_x:bottom_right_x,1,k) = value1;
                taggedCars(bottom_left_y,bottom_left_x:bottom_right_x,2,k) = value2;
                taggedCars(bottom_left_y,bottom_left_x:bottom_right_x,3,k) = value3;
                
                taggedCars(top_left_y:bottom_left_y,top_left_x,1,k) = value1;
                taggedCars(top_left_y:bottom_left_y,top_left_x,2,k) = value2;
                taggedCars(top_left_y:bottom_left_y,top_left_x,3,k) = value3;
                
                taggedCars(top_left_y:bottom_left_y,top_right_x,1,k) = value1;
                taggedCars(top_left_y:bottom_left_y,top_right_x,2,k) = value2;
                taggedCars(top_left_y:bottom_left_y,top_right_x,3,k) = value3;
                
                %                 border = 10;
                %                 try
                %                     temp = realFrame(top_left_y-border:bottom_left_y+border,top_left_x-border:top_right_x+border,:);
                %                     outname = sprintf('objects/%d_%d.bmp', k, z);
                %                     imwrite(temp, outname);
                %                 catch exception
                %
                %                 end
            end
            %end
        end
        
%         imshow(taggedCars(:,:,:,k));
%         
%         for z = 1 : length(stats)
%             idx = z;
%             c = stats(idx).Centroid;
%             c = floor(fliplr(c));
%             
%             text(c(2),c(1),{sprintf('%d',z)});
%         end
        
        %areaArray = [stats.Area];
        %[junk,idx] = max(areaArray);
        
    end
    %     catch exception
    %         disp(exception)
    %     end
    
    k
end
