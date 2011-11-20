function [K,IMAGE] = car_detector(M,IMAGE)

windowSize = 33;
%windowSize = 40;
threshold = windowSize*windowSize/2;
M = [M;bounding_box_iterator(IMAGE,windowSize,threshold)];
% 
% figure;
% imshow(IMAGE);
% hold on;
% plot(M(:,2),M(:,1),'y*');


P = get_clusters(M,40);
%     imshow(I);
%     hold on;
%     plot(CARS(:,2),CARS(:,1),'r*');
%     
%     disp(length(P));
%     for i = 1:length(P)
%         disp(P{i});
%         plot(P{i}(:,2), P{i}(:,1), 'r*');
%     end


 
K = [];
% for i = 1:length(P)
%    K(i,:) = P{i}(1,:);
% end
for i = 1:length(P)
    K= [K;best_point(P{i}) windowSize];
end

IMAGE = detected_object_eraser(IMAGE,M);

end