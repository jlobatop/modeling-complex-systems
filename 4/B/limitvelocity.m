function vel = limitvelocity(boidVel, vlim)
% LIMITVELOCITY: function that limitates the maximum possible velocity of
% the boids
%
% INPUTS:
% boidVel = boids velocity (do NOT include position)
% vlim    = maximum allowable boid velocity
%
% OUTPUTS:
% vel = new boid velocity
%
% Xing Jin and Javier Lobato, created on 2018/04/03

% Preallocation of the output matrix
vel = zeros(length(boidVel),2);

% Loop over all the n boids
for i = 1:length(boidVel)
    % If the modulus of the velocity of the i-th boid is over the limit
    if norm(boidVel(i,:)) > vlim
        % Set the velocity to keep the same direction but the magnitude
        % established in the limit velocity
        vel(i,:) = vlim*(boidVel(i,:)/norm(boidVel(i,:)));
    else
        % If it is under the limit, don't modify the velocity
        vel(i,:) = boidVel(i,:);
    end
end
    
end

