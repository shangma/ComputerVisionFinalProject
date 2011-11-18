images = [];
for i = 0001:50:1000
    S = 'traffic-images/traffic-';
    if (i < 10)
        S = strcat(S, '000', num2str(i));
    elseif (i < 100)
        S = strcat(S, '00', num2str(i));
    elseif (i < 1000)
        S = strcat(S, '0', num2str(i));
    else
        S = strcat(S, num2str(i));
    end
    S = strcat(S, '.jpeg');
    I = imread(S);
    I = im2double(I);
    I = I(:)';   
    images = [images; I];
    %imshow(I);
end

%imshow(images(1));