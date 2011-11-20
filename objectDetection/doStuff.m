%function doStuff()

warning off all;

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



%for i = 243 %1:10
i = 243;
I = imread(images{i});
USING = i;

figure;
imshow(I);
hold on;

[CARS_DETECTED,I] = car_detector([],I);

figure;
imshow(I);
hold on;

plot(CARS_DETECTED(:,2),CARS_DETECTED(:,1),'b*');





%
%
%     PEOPLE = [];
%     PEOPLE = people_detector(PEOPLE,I);
%
%     figure;
%     imshow(I);
%     hold on;
%     plot(PEOPLE(:,2),PEOPLE(:,1),'y*');

% end

%end
