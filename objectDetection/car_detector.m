function [M] = car_detector(M,IMAGE)

windowSize = 33;
threshold = windowSize*windowSize/2
M = [M;bounding_box_iterator(IMAGE,windowSize,threshold)];
% 
% figure;
% imshow(IMAGE);
% hold on;
% plot(M(:,2),M(:,1),'y*');



end