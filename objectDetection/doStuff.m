%function doStuff()

close all;

images = images_iterator;

% I = imread(images{243});
% M = bounding_box_iterator(I,40);
% P = get_clusters(M,40);
% USING = 243;
% 
% imshow(I);
% hold on;
% %plot(M(:,2),M(:,1),'r*');
% 
% disp(length(P));
% for i = 1:length(P)
%     disp(P{i});
%     plot(P{i}(:,2), P{i}(:,1), 'r*');


% I = imread(images{243});
% USING = 243;



for i = 243 %1:10
    
    I = imread(images{i});
    USING = i;
    
    CARS = [];
    CARS = car_detector(CARS,I);
    
%     ORIGINAL_IMAGES{i} = I;
%     CAR_LIST{i} = CARS;
    figure;
    imshow(I);
    hold on;
    plot(CARS(:,2),CARS(:,1),'y*');


    I = detected_object_eraser(I,CARS);
    
    figure;
    imshow(I);
    
    
%     ERASED_IMAGES{i} = I;
     
    PEOPLE = [];
    PEOPLE = people_detector(PEOPLE,I);
    
    figure;
    imshow(I);
    hold on;
    plot(PEOPLE(:,2),PEOPLE(:,1),'y*');
%     
%     PEOPLE_LIST{i} = PEOPLE;

end

%end
