function [M] = people_detector(M,IMAGE)



windowSize = 10;
threshold = windowSize*windowSize/1.5;
M = [M;bounding_box_iterator(IMAGE,windowSize,threshold)];

% 
% figure;
% imshow(I);
% hold on;
% plot(M(:,2),M(:,1),'y*');
% 


end