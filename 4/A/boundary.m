function boid = boundary(dim,boid)
% BOUNDARY: function that bounces the boids inside the grid if they get to
% the walls with the same velocity it hit the wall
%
% INPUTS:
% dim  = size of the domain
% boid = boids position and velocity
%
% OUTPUTS:
% boid = boids position and velocity
%
% Xing Jin and Javier Lobato, created on 2018/04/03

% Loop over all the boids
for j = 1:size(boid,1)
    % Bounce on the horizontal direction
    % If the boid moves to negative x-axis
    if boid(j,1) < 0
        boid(j,1) = - boid(j,1);
        boid(j,3) = - boid(j,3);
    % If it leaves the grid on the right side
    elseif boid(j,1) > dim
        boid(j,1) = 2*dim - boid(j,1);
        boid(j,3 )= - boid(j,3);
    end
    % Bounce on the vertical direction
    % If the boid moves to the negative y-axis
    if boid(j,2) < 0
        boid(j,2) = - boid(j,2);
        boid(j,4) = - boid(j,4);
    % If the boid moves upper a distance of dim
    elseif boid(j,2) > dim
        boid(j,2) = 2*dim - boid(j,2);
        boid(j,4) = - boid(j,4);
    end
end

end