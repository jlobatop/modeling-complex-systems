function [max_dist] = swarmModel(n,dim,ts,zor,zop,fov,k,coe,prd,prdSpd,vLim,vCorr,plop,pltFov,arr,figNo,visionMode)
%SWARMMODEL: simulation of a BOIDS swarm model based on the pseudo code
%taken from http://www.vergenet.net/~conrad/boids/pseudocode.html
%
% INPUTS:
% n          = number of boids
% dim        = size of the domain
% ts         = simulation time
% zor        = radius of the zone of repulsion
% zop        = radius of the zone of predator avoidance
% fov        = field of view angle
% k          = number of closest neeighbors
% coe        = weighting of the velocity from each rule
% prd        = predator flag
% prdSpd     = predator speed
% vLim       = velocity limit for the boids
% vCorr      = velocity correction for the boids leaving bounds
% plop       = plotting  options, true to plot, false to not
% pltFov     = zor and fov plotting flag
% arr        = arrows plotting flag
% figNo      = number of figure to avoid superposition
% visionMode = vector with three components for different neighborhoods
%
% OUTPUTS:
% plot of the desired simulation case setup
% 
% Xing Jin and Javier Lobato, created on 2018/04/03
% Javier Lobato, last modified on 2018/04/15

% Initialize position and velocity of the flock
[boid,pred] = initialization(dim,n,prd);

% Create a new figure to avoid superposition
if plop
    figure(figNo)
end

% Test visionMode vector to analyze its possibilities:
%      [0 0 0] -> not valid configuration
%      [1 0 0] -> zor (zone of repulsion)
%      [0 1 0] -> fov (field of vision)
%      [0 0 1] -> kn (k-nearest boids)
%      [1 1 0] -> zf (zone of repulsion + field of vision)
%      [1 0 1] -> not valid configuration (additive configuration)
%      [0 1 1] -> fk (field of vision + k-nearest)
%      [1 1 1] -> not valid configuration (additive configuration)

% The invalid configurations will raise an error and exit the function
if sum(visionMode) == 3
    error('Not valid visionMode vector')
    % To force the system to leave the function, let's limit ts as zero
    ts = 0;
elseif sum(visionMode) == 0
    error('Not valid visionMode vector')
    ts = 0;
elseif sum(visionMode) == 2
    if visionMode(3) == 0
        vM = 'zf';
    elseif visionMode(1) == 0
        vM = 'fk';
    else 
        error('Not valid visionMode vector')
        ts = 0;
    end    
elseif sum(visionMode) == 1
    if visionMode(1) == 1
        vM = 'zor';
    elseif visionMode(2) == 1
        vM = 'fov';
    else 
        vM = 'kn';
    end
end

% Preallocation of space for the maximum distance array
max_dist = zeros([(ts+1),1]);

% Calculation of the maxmimum distance for the initialization
max_dist(1) = maxDist(boid(:,1:2));

% If the pltFov flag is True, get the index for the boid to track
if pltFov
    ind = randsample(length(boid),1);
    boid(ind,1:2) = dim/2;
else
    ind = 1; % Otherwise define it as 1 although it won't be used
end

% Time loop from 1 until the specified ts
for i=1:ts
    % Update the position of the boids
    boid = updateboid(dim,n,boid,prd,pred,coe,zor,zop,fov,k,vLim,vCorr,vM);
        % (If there is a predator, also update it) though it will never be
        % a predator in the current experiment setup
        if prd
             pred = updatepred(dim,n,boid,pred,prdSpd);
        end
    % Plot current position of boids and predator if desired
    if plop
        pltdistribution(dim,boid,prd,pred,arr,pltFov, zor, fov, k, ind, visionMode)
    end
    % Pause to see the figure
    pause(0.001)
    % Calculations of the largest distance between birds
    max_dist(i+1) = maxDist(boid(:,1:2));
end

end

