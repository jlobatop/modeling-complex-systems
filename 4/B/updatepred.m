function pred = updatepred(dim, n, boid, pred, prdSpeed)
% UPDATEPRED: updates the position of the predator 
%
% INPUTS:
% dim      = size of domain
% n        = number of boids
% boid     = boids position and velocity
% pred     = predator position and velocity
% prdSpeed = predator maximum speed
%
% OUTPUTS:
% pred = array with updated position and velocity of the predator
% 
% Xing Jin & Javier Lobato 2018/04/03

% Get the true center of gravity of the flock
c = sum(boid(:,1:2))/n;

% Move the predator with the desired speed towards the center of gravity
pred(3:4) = prdSpeed*(c-pred(1:2))/norm(c-pred(1:2));
    
% Update the position of the predator with the new velocity
pred(1) = pred(1)+pred(:,3);
pred(2) = pred(2)+pred(:,4);

% If the predator is over the boundaries of the grid, it must also bounce
pred = boundary(dim, pred); 

end