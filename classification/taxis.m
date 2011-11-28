trainingDir = '../taxis/';
trainingDir = '../training/cars/';
trainingDir = '../training/bikes/';
%trainingDir = '../taxis2/';
listing = dir(trainingDir);

for i = 3 : length(listing)
    path = strcat(trainingDir,listing(i).name);
    I = imread(path);
    [r,g,b] = rgb_mean(I);
    
    R(i-2) = r;
    G(i-2) = g;
    B(i-2) = b; 
end

mean_r = mean(R)
mean_g = mean(G)
mean_b = mean(B)
std_r = std(R)
std_g = std(G)
std_b = std(B)
