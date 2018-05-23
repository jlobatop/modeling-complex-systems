function v1 = rule1(n,boid)
% RULE1: function that calculates the effect of Rule 1: boids try to fly 
% towards the center of mass of the neighboring boids.
%
% INPUTS:
% n     = number of boids
% boids = boids position and velocity
%
% OUTPUTS:
% v1    = correction of the velocity for rule 1
% 
% Xing Jin and Javier Lobato, created on 2018/04/03

% Preallocation of the output matrix
v1 = zeros(n,2);

% Loop over n boids
for i = 1:n
    % Copy the position of all boids
    tem = boid(:,1:2);
    % Erase the row of the current i-th boid
    tem(i,:) = [];
    % Compute the mean of the position (relative center of gravity)
    xave = mean(tem(:,1));
    yave = mean(tem(:,2));
    % Direct the current boid position to the center of gravity
    v1(i,1:2) = [xave, yave] - boid(i,1:2);
end

end