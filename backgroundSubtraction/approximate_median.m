% This m-file implements the approximate median algorithm for background
% subtraction.  It may be used free of charge for any purpose (commercial
% or otherwise), as long as the author (Seth Benton) is acknowledged.

clear all;

%source = mmreader('../test_video/traffic.avi');
%source = mmreader('../test_video/san_fran_traffic_30sec_QVGA_Cinepak.avi');
%source = aviread('C:\Video\Source\traffic\san_fran_traffic_30sec_QVGA');

thresh = 25;
load('median.mat','median');

f = imread('../traffic-images/traffic-0001.jpeg');
%f = double(rgb2gray(f)); 

%diff = f - double(uint8(median));

%imshow(diff);

t = f(:,:);

diff2 = backnoise(t,median);

imshow(diff2);

%%

%bg = source(1).cdata;           % read in 1st frame as background frame
bg = imread('../traffic-images/traffic-0000.jpeg');
bg_bw = double(rgb2gray(bg));     % convert background to greyscale
mask_bw = double(rgb2gray(imread('mask.bmp')));

% ----------------------- set frame size variables -----------------------
fr_size = size(bg);             
width = fr_size(2);
height = fr_size(1);
fg = zeros(height, width);

% --------------------- process frames -----------------------------------

for i = 1:836
    S = '../stable/';
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
S = strcat(S, num2str(i));
S = strcat(S, '.bmp');
    
    fr = imread(S);
    fr_bw = rgb2gray(fr);       % convert frame to grayscale
    
    if (i < 100)
        fr_diff = abs(double(fr_bw) - double(median));  % cast operands as double to avoid negative overflow
    else
        fr_diff = abs(double(fr_bw) - double(bg_bw));  % cast operands as double to avoid negative overflow
    end

    for j=1:width                 % if fr_diff > thresh pixel in foreground
         for k=1:height
             if mask_bw(k,j) == 0
                 fg(k,j) = 0;
             else
                 if ((fr_diff(k,j) > thresh))
                     fg(k,j) = fr_bw(k,j);
                 else
                     fg(k,j) = 0;
                 end
             end

             if (fr_bw(k,j) > bg_bw(k,j))
                 bg_bw(k,j) = bg_bw(k,j) + 1;           
             elseif (fr_bw(k,j) < bg_bw(k,j))
                 bg_bw(k,j) = bg_bw(k,j) - 1;     
             end

         end    
    end

    %figure(1),
    %subplot(2,1,1),imshow(uint8(bg_bw))
    %subplot(2,1,2),imshow(uint8(fg))   
    
    M(i) = im2frame(uint8(fg),gray(256));           % save output as movie
    %M(i) = im2frame(uint8(bg_bw),gray);             % save output as movie
    
    %outname = sprintf('../output/%d.bmp', i);
    %imwrite(fg, outname);
    i
end

movie2avi(M,'test','fps',30);           % save movie as avi    
