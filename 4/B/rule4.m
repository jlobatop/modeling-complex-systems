function v4 = rule4(n,boid,pred,zop,fov)
% RULE4: function that calculates the effect of Rule 4: boids try to avoid
% a possible incoming predator
%
% INPUTS:
% n     = number of boids
% boids = boids position and velocity
% pred  = current predator position and velocity
% zop   = (circular) zone of predator avoidance
% fov   = angle (in radians) of the boid field of view
%
% OUTPUTS:
% v4    = correction of the velocity for rule 4
% 
% Xing Jin and Javier Lobato, created on 2018/04/03
% Javier Lobato, last modified on 2018/04/15

% Given that the test will be carried out without any predator, this rule
% will not be updated with the different possible neighborhood cases

% Preallocation of the output matrix
v4 = zeros(n,2);

% Loop over n boids
for i = 1:n
    % Get the distance of the i-th boid to the  predator 
    dis = boid(i,1:2) - pred(1:2);
    % Get the current boid velocity and transpose
    vel = (boid(i,3:4))';
    % If both the predator is inside the field of view and the radius of
    % the zone of predator avoidance
    if acos(dot(dis,vel)/norm(dis)/norm(vel))<fov/2 && abs(norm(dis))<zop
        % Modify the velocity of the i-th boid to avoid the predator
        v4(i,1:2) = (boid(i,1:2)-pred(1:2));
    end
end

end