% modified version of  match_corners_NCC
% It also divides by the euclidian distance to help weight nearby pixels
% stronger than pixels far away
function [m1,m2] = match_corners_NCC_modified(I1,I2,corners1,corners2,ws)


WS = 2*ws + 1;
m1 = [];
m2 = [];

template1 = cell(length(corners1),1);
for i = 1:length(corners1)
    T = imcrop(I1, [corners1(1,i)-(WS/2),corners1(2,i)-(WS/2),WS,WS]);
    if ~isempty(T)
        template1{i} = T(:);
    end
end
template2 = cell(length(corners2),1);
for i = 1:length(corners2)
    T = imcrop(I2, [corners2(1,i)-(WS/2),corners2(2,i)-(WS/2),WS,WS]);
    if ~isempty(T)
        template2{i} = T(:);
    end
end


for i = 1:length(corners1)
    if ~isempty(template1{i})
        nccscores = NaN(length(corners2),1);
        for j = 1:length(corners2)
            if ~isempty(template2{j}) && (numel(template1{i}) == numel(template2{j}))
                nccscores(j) = NCC_value(template1{i},template2{j})/euclidian_distance(corners1(1,i),corners1(2,i),corners2(1,j),corners2(2,j));
            end
        end
        [~,j] = max(nccscores);
        m1 = vertcat(m1,corners1(:,i)');
        m2 = vertcat(m2,corners2(:,j)');
    end
end
end




