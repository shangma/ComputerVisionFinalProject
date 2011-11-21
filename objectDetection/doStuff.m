%function doStuff()

warning off all;

close all;
clear all;

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


for i = 1:500%1098 %243:245
    
    
    close all;
    %i = 243;
    I = imread(images{i});
    USING = i;
%     
%     figure;
%     imshow(I);
%     hold on;
    
    [CARS_DETECTED,I] = car_detector([],I);
%     
%     h = figure;
%     imshow(I);
%     hold on;
%     plot(CARS_DETECTED(:,2),CARS_DETECTED(:,1),'b*');  
%     hold off;
%     
    ALL_CARS_DETECTED{i} = CARS_DETECTED;
    
    
%     F = getframe(h);
     
%     out = image(F.cdata);
     
%     N(i-242) = im2frame(uint8(out),gray(256));           % save output as movie

end


% movie2avi(N,'adsf','fps',30);           % save movie as avi    


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
