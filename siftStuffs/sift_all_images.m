function [P,D] = sift_all_images

images = images_iterator;

N = length(images);

P = zeros(N);
D = zeros(N);

for i = 1:N
   String = images(i,:);
   
   I = imread(String);
   I_gray = rgb2gray(I);
   I_single = im2single(I_gray);
   
   [FRAME, DESCRIPTOR] = vl_sift(I_single);
   
 
   P{i} = FRAME;
   D{i} = DESCRIPTOR;
   
end


end