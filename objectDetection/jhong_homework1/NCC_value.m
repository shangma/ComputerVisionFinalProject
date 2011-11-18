function C = NCC_value(F,T)

F = F - mean(F);
T = T - mean(T);

F = F./norm(F);
T = T./norm(T);

C = dot(F,T);
end
