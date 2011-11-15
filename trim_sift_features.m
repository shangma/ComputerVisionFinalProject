clear all;
close all;

load('siftstuff.mat','P','D');

%%

clear newP;
clear newD;

numFrames = length(P);

for i = 1 : numFrames
    featureCoordinates = P{i};
    featureCoordinates = featureCoordinates(1:2,:); % only care about x and y
    featureDescriptors = D{i};
    
    numFeatures = length(featureCoordinates);
    
    clear pTemp;
    clear dTemp;
    
    numValidFeatures = 1;
    size(featureCoordinates)
    
    for j = 1 : numFeatures
        x = featureCoordinates(1,j);
        y = featureCoordinates(2,j);
        
        if validCoordinateRegion(x,y) == 1
            pTemp(1,numValidFeatures) = x;
            pTemp(2,numValidFeatures) = y;
            dTemp(1:128,numValidFeatures) = featureDescriptors(1:128,j);
            numValidFeatures = numValidFeatures+1;
        end
    end
    
    newP{i} = pTemp;
    newD{i} = dTemp;
end