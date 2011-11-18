images = images_iterator();

start_frame_num = 1;
end_frame_num = length(images);

load('siftstuff.mat','P','D');

for vframe = start_frame_num : 1 : end_frame_num
    T = zeros(3,3);
    count = 0;
    filename1 = images(vframe,:);
    % use a sliding window of length 31
    for tframe = vframe-15 : 1 : vframe+15
        
        if tframe < 1
            continue;
        end
        
        count = count + 1;
        
        filename2 = images(tframe,:);
        
        p1 = P{vframe};
        p2 = P{tframe};
        d1 = D{vframe};
        d2 = D{tframe};
        
        [m1 m2] = sift_matcher(p1,p2,d1,d2);
        
        m1 = m1(1:2,:);
        m2 = m2(1:2,:);
        
        % match the feature points
        %         distRatio = 0.6;
        %
        %         des2t = des2';                          % Precompute matrix transpose
        %         for i = 1 : size(des1,1)
        %             size(des1(i,:))
        %             size(des2t)
        %             dotprods = dot(des1(i,:),des2t);        % Computes vector of dot products
        %             [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results
        %
        %             if (vals(1) < distRatio * vals(2))
        %                 match(i) = indx(1);
        %             else
        %                 match(i) = 0;
        %             end
        %         end
        %
        %         inp = [];
        %         outp = [];
        %         for i = 1: size(des1,1)
        %             if (match(i) > 0)
        %                 inp = [inp; loc1(i,2), loc1(i,1)];
        %                 outp = [outp; loc2(match(i),2), loc2(match(i),1)];
        %             end
        %         end
        
        %         size(outp)
        %         size(outp')
        
        inp = m1';
        outp = m2';
        
        size(inp)
        size(outp)
        
        % compute the similarity transformation
        tt = cp2tform(inp, outp, 'linear conformal');
        L = tt.tdata.T;
        scale = sqrt(L(1,1)^2 + L(1,2)^2);
        L(:,1:2) = L(:,1:2)/scale;
        % sum the transforms up
        T = T + L;
    end
    
    % get the average transformation
    T = T/count;
    
    % warping by backprojection.
    % inv(T) is the transform from target back to the original image
    T = inv(T);
    
    im = imread(filename1);
    im = im2double(im);
    width = size(im, 2);
    height = size(im, 1);
    % x and y are coordinates on the warped image
    [x,y] = meshgrid(1:width, 1:height);
    nxy = [x(:), y(:), ones(length(x(:)), 1)] * T;
    % newx and newx are corresponding point coordinates in the original image
    newx = reshape(nxy(:,1), height, width);
    newy = reshape(nxy(:,2), height, width);
    
    % get the value of each pixel in the warp image by bi-linear interpolation
    imt1 = interp2(im(:,:,1), newx, newy, 'linear');
    imt2 = interp2(im(:,:,2), newx, newy, 'linear');
    imt3 = interp2(im(:,:,3), newx, newy, 'linear');
    imt = cat(3, imt1, imt2, imt3);
    imshow(imt);
    outname = sprintf('stable/%d.bmp', vframe);
    imwrite(imt, outname);
end