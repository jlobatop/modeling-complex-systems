function boid = updateboid(dim,n,boid,prd,pred,coe,zor,zop,fov,velLim,velCorr)
% UPDATEBOID: updates the position of each boid using the different rules
%
% INPUTS:
% dim   = size of domain
% n     = number of boids
% boids = boids position and velocity
% prd   = predator flag
% coe   = weighting of the velocity from each rule
% zor   = radius of the zone of repulsion 
% zop   = radius of the zone of predator avoidence
% fov   = field of view angle
%
% OUTPUTS:
% boid  = array with updated position and velocities
% 
% Xing Jin & Javier Lobato 2018/04/03

% Compute the variations in velocity for each rule
v1 = rule1(n,boid);
v2 = rule2(n,boid,zor,fov);
v3 = rule3(n,boid);

% The fourth rule will one be computed if the predator flag is True
if (prd)
    v4 = rule4(n,boid,pred,zop,fov);
else
    v4 = 0;
end

% Update the velocity with the variations and their respective weights
boid(:,3:4) = boid(:,3:4) + coe(1)*v1 + coe(2)*v2 + coe(3)*v3 + coe(4)*v4; 
% If the velocity if over the limit, correct it
boid(:,3:4) = limitvelocity(boid(:,3:4), velLim);

% Update the position with the new velocity
boid(:,1) = boid(:,1) + boid(:,3);
boid(:,2) = boid(:,2) + boid(:,4);

% Correct velocity if the boid is going out of bounds (bounds = +-0.1*dim)
boid(:,3:4) = boid(:,3:4) + boundposition(boid(:,1:2), ...
    [dim/10, 9*dim/10, dim/10, 9*dim/10], velCorr);

% If boids are in the boundary, bounce them
boid = boundary(dim,boid); 

end