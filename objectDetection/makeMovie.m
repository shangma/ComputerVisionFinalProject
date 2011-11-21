

close all;

for i=50:500
    
   %h =figure;
%    set(h,'Position',[0 0 480 720]);
   Q = imread(images2{i});
   imshow(Q);
   hold on;
   plotthis = ALL_CARS_DETECTED{i}; 
   
   if length(plotthis) > 1
    plot(plotthis(:,2),plotthis(:,1),'kd-');
   end
%    f = getframe;
%    m(i) = f;
%   
   %close all;
   pause(0.1);
end
 
% movie2avi(m,'blah','fps',30);