function v2=rule2(n,boid,zor,fov)
% RULE2: function that calculates the effect of Rule 2: boids try to keep 
% certain distance with their neighbors
%
% INPUTS:
% n     = number of boids
% boids = boids position and velocity
% zor   = (circular) zone of repulsion
% fov   = angle (in radians) of the boid field of view
%
% OUTPUTS:
% v2    = correction of the velocity for rule 2
% 
% Xing Jin and Javier Lobato, created on 2018/04/03

% Preallocation of the output matrix
v2 = zeros(n,2);

% Loop over n boids
for i = 1:n
    % Copy the position of all boids
    tem = boid(:,1:2);
    % Erase the row of the current i-th boid
    tem(i,:) = [];
    % Get the current i-th boid
    bi = boid(i,1:2);
    % Loop over the other n-1 boids
    for j = 1:n-1
        % Store the relative position vector between boid j and boid i
        dis = tem(j,:) - bi;
        % If the modulus of the distance is smaller than the specified
        % radius and the angle is included within the field of vision
        if abs(norm(dis)) < zor && acos(dot(dis,boid(i,3:4))/(norm(dis)*norm(boid(i,3:4)))) < fov/2
            % Repel the i-th bird with respect the j-th bird and accumulate
            % the consecutive repulsion of all the n-1 birds
            v2(i,1:2) = v2(i,1:2) - dis;
        end
    end
end

end