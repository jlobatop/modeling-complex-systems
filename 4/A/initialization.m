function [boid, pred] = initialization(dim,n,prd)
% INITIALIZATION: function to create random initial boid (and predator)
% positions and velocity
%
% INPUTS:
% n     = number of boids
% dim = size of the domain
% prd = if True, include the predator in the simulation 
%
% OUTPUTS:
% boids = nx4 with n boids position and velocity in both components
% pred  = 1x4 with predator position and velocity in both components
% 
% Xing Jin and Javier Lobato, created on 2018/04/03

% Loop over boids and fill in random position and velocity inside limits
boid(:,1:2) = rand(n,2)*dim;
boid(:,3:4) = (rand(n,2)*2-1)*dim*0.02;

% Initialize predator location and velocity if desired
if prd
    pred(:,1:2) = rand(1,2)*dim;
    % Contrary to the boids, initialize the predator with zero velocity
    pred(:,3:4) = [0 0];
else
    % Case where no predator is desired
    pred = [];
end

end