clear all;
close all;

in_dir = '../traffic-images/';
out_dir = '../taxis/';
obj_type = 'taxi';

i = 1;

% 
% 
% for i = 0001:1098
%     S = '../traffic-images/traffic-';
%     if (i < 10)
%         S = strcat(S, '000', num2str(i));
%     elseif (i < 100)
%         S = strcat(S, '00', num2str(i));
%     elseif (i < 1000)
%         S = strcat(S, '0', num2str(i));
%     else
%         S = strcat(S, num2str(i));
%     end
%     S = strcat(S, '.jpeg');
%     %I = imread(S);
%     %I = im2double(I);
%     %I = I(:)';   
%     %images = [images; I];
%     images = [images;S];
% 
% end





for frame=(0:20:200)
    
     S = '../traffic-images/traffic-';
    if (frame < 10)
        S = strcat(S, '000', num2str(frame));
    elseif (frame < 100)
        S = strcat(S, '00', num2str(frame));
    elseif (frame < 1000)
        S = strcat(S, '0', num2str(frame));
    else
        S = strcat(S, num2str(frame));
    end
    S = strcat(S, '.jpeg');
    
    in_img = S;
    
    %in_img = sprintf('%s%d.jpg', in_dir, frame)
    im = im2double(imread(in_img));
    f = figure, image(im)
    hold on
    
    ctr = 0;
    top_left = zeros(2);
    bot_right = zeros(2);
    while(true)
        [x, y, button] = ginput(1);

        if button ~= 1 && button ~= 3
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