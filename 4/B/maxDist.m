function [ max_dist ] = maxDist(boidPos)
% MAXDIST: function that computes the maximum distance between boids in the
% current flock distribution. Computing the distance between one bird to 
% every other bird, taking the maximum, repeating that for all birds and 
% taking the maximum of the maximums is an inefficient way of computing the
% maximum distance between two points. Following the advice desrcibed:
%            https://stackoverflow.com/a/8006849
% the maximum distance between the boids can be computed without the need
% of looping twice the array
%
% INPUTS:
% boidPos  = position of the boids in the flock
%
% OUTPUTS:
% max_dist = value of the maximum distance 
% 
% Javier Lobato, created on 2018/04/15

% Let's add the components x+y and store them
adding = boidPos(:,1) + boidPos(:,2);
% Let's substract the components x-y and store them
substracting = boidPos(:,1) - boidPos(:,2);

% Lower left point is the min(x+y)
[~, ill] = min(adding);
% Upper left point is the min(x-y)
[~, iul] = min(substracting);
% Upper right point is the max(x+y)
[~, iur] = max(adding);
% Lower right point is the max(x-y)
[~, ilr] = max(substracting);

% Let's compute the distance between the most lower left and most upper
% right point
d1 = sqrt((boidPos(ill,1)-boidPos(iur,1))^2 + (boidPos(ill,2)-boidPos(iur,2))^2);
% Let's compute the distance between the most upper left and most upper
% left point
d2 = sqrt((boidPos(iul,1)-boidPos(ilr,1))^2 + (boidPos(iul,2)-boidPos(ilr,2))^2);

% Take the biggest of these two measures
max_dist = max(d1,d2);

end

