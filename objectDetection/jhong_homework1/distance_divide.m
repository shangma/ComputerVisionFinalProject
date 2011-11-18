function [NCC] = distance_divide(x,y,NCC)








A = zeros(size(NCC,1),size(NCC,2));

for i = 1:size(NCC,1)
    for j = 1:size(NCC,2)
        A(i,j) = euclidian_distance(x,y,i,j);
        
    end
    
    
    
end


NCC = NCC./A;

end
