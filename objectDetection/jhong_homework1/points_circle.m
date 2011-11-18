
function  [P] = points_circle(C,r,n)
    theta = linspace(0,2*pi-((2*pi)/n),n);
    
    x = C(1) + r*cos(theta); 
    y = C(2) + r*sin(theta);
    
    P = [x;y];
    
    
    % USAGE:
    % P = points_circle([0;0],1,100)
    % plot(P(1,:),P(2,:),'b.')
end