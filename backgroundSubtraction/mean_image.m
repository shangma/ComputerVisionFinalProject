images = images_iterator;

bg = imread(images(1,:));
bg = rgb2gray(bg);
bg = im2double(bg);

for i = 2:1098
    S = images(i,:);
    I = imread(S);
    I = rgb2gray(I);
    I = im2double(I);
    bg = bg + I;
end

bg = bg / 1098;
imshow(bg);
imwrite(bg,'mean_image.jpeg','jpeg');