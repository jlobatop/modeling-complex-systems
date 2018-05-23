function v3 = rule3(n,boid)
% RULE3: function that calculates the effect of Rule 3: boids try to match
% the velocity with the mean velocity
%
% INPUTS:
% n     = number of boids
% boids = boids position and velocity
%
% OUTPUTS:
% v3    = correction of the velocity for rule 3
% 
% Xing Jin and Javier Lobato, created on 2018/04/03

% Preallocation of the output matrix
v3 = zeros(n,2);

% Loop over n boids
for i = 1:n
    % Copy the velocity of all boids
    tem = boid(:,3:4);
    % Erase the row of the current i-th boid
    tem(i,:) = [];
    % Compute the mean of the veloicty 
    vxave = mean(tem(:,1));
    vyave = mean(tem(:,2));
    % Match the mean velocity with the i-th boid's velocity
    v3(i,1:2) = [vxave,vyave] - boid(i,3:4);
end

end