clear all;
close all;

images = images_iterator();
imagesLength = length(images);

referenceFrame = 1;

load('trim2.mat','P','D');
%load('m1m2.mat','A','B');
%load('stabilize.mat','A','B','C');
I1 = im2double(imread(images(referenceFrame,:)));

for i = 1 : 200
     p1 = P{referenceFrame};
     p2 = P{i};
     d1 = D{referenceFrame};
     d2 = D{i};
     
     p1 = p1(1:2,:);
     p2 = p2(1:2,:);
     
     [m1 m2] = sift_matcher(p1,p2,d1,d2);
%      m1 = A{i};
%      m2 = B{i};
%      H = C{i};

    [H] = RANSAC_ndlt(m1,m2);
    
    A{i} = m1;
    B{i} = m2;
    C{i} = H;
    
    I2 = im2double(imread(images(i,:)));
    K = blend(I1,I2,H);
    
    %M(i) = im2frame(K);
    outname = sprintf('stable/%d.bmp', i);
    imwrite(K, outname);
    
    i
end

%movie2avi(M,'noah','fps',30);
