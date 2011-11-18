function [mu] = e(I1,I2)
    mu = sum((I1(:)-I2(:)).^2)/(numel(I1));
end