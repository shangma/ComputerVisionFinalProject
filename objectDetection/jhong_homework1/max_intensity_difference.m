function [M] = max_intensity_difference(I1,I2)
    M = max(I1(:)-I2(:));
end