function [P,D] = sift_all_images

images = images_iterator;

%P = [];
%D = [];

for i = 1:length(images);
   String = images(i,:);
   
   I = imread(String);
   I_gray = rgb2gray(I);
   I_single = im2single(I_gray);
   
   [FRAME, DESCRIPTOR] = vl_sift(I_single);
   
   % im going to take the 1st and 2nd rows of FRAME. Because those are the
   % x and y coordinates. I don't know what I am supposed to do with the
   % 3rd and 4th rows of FRAME. Apparently the 3rd row is supposed to be
   % the "Scale" and the 4th row is supposed to be the "Orientation"
   
 
   P{i} = FRAME;
   D{i} = DESCRIPTOR;
   
   %P = [P ; FRAME(1,:) ; FRAME(2,:)];
   %D = [D ; DESCRIPTOR];
   
end


end