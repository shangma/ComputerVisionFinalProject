function doStuff()

images = images_iterator;
I = imread(images{243});
M = bounding_box_iterator(I,40);
P = get_clusters(M,40);
USING = 243;

imshow(I);
hold on;
%plot(M(:,2),M(:,1),'r*');

disp(length(P));
for i = 1:length(P)
    disp(P{i});
    plot(P{i}(:,2), P{i}(:,1), 'r*');
end

end