function [ m1,m2 ] = sift_matcher( p1,p2,d1,d2 )
% p1 and p2 are features positions in both images
% d1 and d2 are feataure descriptors in both images
% m1 and m2 are matched feature vectors

[dump, n1] = size(d1);
[dump, n2] = size(d2);

Temp = zeros(2,max(n1,n2));
for i = 1:n1
    for j = 1:n2
        score = sqrt(sum((d1(:,i)-d2(:,j)).^2)); 
        if j==1
            min_score = score;
            Temp(1,i) = 1;
        else
            if score<min_score
                min_score = score;
                Temp(1,i) = j;
            end
        end
    end
    if min_score>95
        Temp(1,i) = 0;
    end
end
for i = 1:n2
    for j = 1:n1
        score = sqrt(sum((d2(:,i)-d1(:,j)).^2)); 
        if j==1
            min_score = score;
            Temp(2,i) = 1;
        else
            if score<min_score
                min_score = score;
                Temp(2,i) = j;
            end
        end
    end
    if min_score>95  % Pose a limit on the distance to eliminate unnecessary matches
        Temp(2,i) = 0;
    end
end

t = 0;
for i = 1:max(n1,n2)
    if Temp(1,i)~=0&&Temp(2,Temp(1,i))==i
        t = t+1;
        m1(:,t) = p1(:,i);
        m2(:,t) = p2(:,Temp(1,i));
    end
end

end

