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

K = [];

if not(isempty(M))
    P = get_clusters(M,40);
    
    for i = 1:length(P)
        K= [K;best_point(P{i}) windowSize];
    end
    IMAGE = detected_object_eraser(IMAGE,M);
    
    
end


 

end