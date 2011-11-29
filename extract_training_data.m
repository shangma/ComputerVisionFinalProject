clear all;
close all;

in_dir = './stable/';
out_dir = './training/bikes/';
obj_type = 'person';

i = 1;
for frame=(1:20:200)
    in_img = sprintf('%s%d.bmp', in_dir, frame)
    im = im2double(imread(in_img));
    f = figure, image(im)
    hold on
    
    ctr = 0;
    top_left = zeros(2);
    bot_right = zeros(2);
    while(true)
        [x, y, button] = ginput(1);

        if button == 3
           break;
        end

        if ctr == 0
            top_left(1) = x;
            top_left(2) = y;
        end
        if ctr == 1
            bot_right(1) = x;
            bot_right(2) = y;
            
            tl1 = min(top_left(1), bot_right(1));
            tl2 = min(top_left(2), bot_right(2));
            br1 = max(top_left(1), bot_right(1));
            br2 = max(top_left(2), bot_right(2));
            
            width = br1 - tl1;
            height = br2 - tl2;

            rectangle('Position',[tl1,tl2,width,height]) ;
        end

        if ctr == 2
            if button == 1
                sub_im = im(tl2:br2, tl1:br1, :);
                out_im = sprintf('%s%s%d-%d.jpg', out_dir, obj_type, i, frame);
                imwrite(sub_im, out_im);
            end
            i = i + 1;
        end

        ctr = mod((ctr + 1), 3);
    end
    herp = 1
end
