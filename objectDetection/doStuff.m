function doStuff()

images = images_iterator;
I = imread(images{243});
M = bounding_box_iterator(I,10);
USING = 243;

imshow(I);
hold on;
plot(M(:,2),M(:,1),'y*');

end