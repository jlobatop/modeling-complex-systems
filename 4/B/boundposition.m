function v5 = boundposition(boids, limits, correction)
%BOUNDPOSITION: function that returns the boids into the limits 
%
% INPUTS:
% boids      = boids position (do NOT include velocity)
% limits     = limits in which the position will be bound
% correction = velocity that will be used to revert the boid inside bounds
%
% OUTPUTS:
% v5         = correction of the velocity for rule 5
% 
% Xing Jin and Javier Lobato, created on 2018/04/03

% Preallocation of the output matrix
v5 = zeros(length(boids),2);

% Loop over n boids
for i=1:length(boids)
    % Minimum horizontal axis position
    if boids(i,1) < limits(1)
        % Positive velocity increment
        v5(i,1) = correction;
    % Maximum horizontal axis position
    elseif boids(i,1) > limits(2)
        % Negative velocity increment
        v5(i,1) = - correction;
    end

    % Minimum vertical axis position
    if boids(i,2) < limits(3)
        % Positive velocity increment
        v5(i,2) = correction;
    % Maximum vertical axis position
    elseif boids(i,2) > limits(4)
        % Negative velocity increment
        v5(i,2) = - correction;
    end
end

end


