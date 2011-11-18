
function  [P] = noisy_points_circle(C,r,n,sig)
    theta = linspace(0,2*pi-((2*pi)/n),n);
    
    noisyRadius = (sig*randn(1,n)) + r;
    
    disp(theta);
    disp(noisyRadius);
    
    
    x = C(1) + cos(theta).*noisyRadius; 
    y = C(2) + sin(theta).*noisyRadius;
    
    P = [x;y];
    
    
    
    
    %P = noisy_points_circle([0;0],1,100,.05)
    %plot(P(1,:),P(2,:),'b.')
    
    
    
    
    %PN = noisy_points_circle([0;0],1,100,.05)
    %plot(P(1,:),P(2,:),'b.'); hold all; plot(PN(1,:),PN(2,:),'r.');
    
end

