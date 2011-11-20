function [P] = get_cluster(M,wind_size)

thresh = .5 * wind_size;
p = libpointer;
i = 1;

while ~isempty(M)
    P{i} = [];
    disp(i);
    if isempty(P{i});
        P{i} = M(1,:);
        M(1,:) = [];
    end
    
    [xP,yP] = size(P{i});
    k = 1;
    restart = 0;
    while (k <= xP)
        [xM,yM] = size(M);
        l = 1;
        while (l <= xM)
            if (is_adjacent(M(l,:),P{i}(k,:),thresh) == 1)
                P{i} = [P{i}; M(l,:)];
                M(l,:) = [];
                restart = 1;
                break;
            end
            l = l + 1;
        end
        k = k + 1;
        if (restart == 1)
            k = 1;
            [xP,yP] = size(P{i});
            restart = 0;    
        end
    end
    
    i = i + 1;
    %                 for k = 1:x
    %
    % %                     disp(k);
    % %                     disp(x);
    % %                     disp(P{j});
    %
    %                     %if (abs(M(i,1) - P{j}(k,1)) == thresh) || (abs(M(i,2) - P{j}(k,2)) == thresh)
    %                     if (is_adjacent(M(i,:),P{j}(k,:), thresh) == 1)
    %                         P{j} = [P{j}; M(i,:)];
    %                         M(i,:) = [];
    %                         found = 1;
    %                     end
    %                     if found == 1
    %                         break;
    %                     end
    %                 end
    %                 if found == 1
    %                     break;
    %                 end
    %             end
    %
    %             if found == 0
    %                 len = length(P);
    %                 P{len+1} = M(i,:);
    %                 M(i,:) = [];
    
    
end

end