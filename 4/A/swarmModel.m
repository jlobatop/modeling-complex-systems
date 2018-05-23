function swarmModel(n,dim,ts,zor,zop,fov,coe,prd,prdSpd,vLim,vCorr,pltFov,arr,figNo)
%SWARMMODEL: simulation of a BOIDS swarm model based on the pseudo code
%taken from http://www.vergenet.net/~conrad/boids/pseudocode.html
%
% INPUTS:
% n     = number of boids
% dim = size of the domain
% ts  = simulation time
% zor = radius of the zone of repulsion
% zop  = radius of the zone of predator avoidance
% fov= field of view angle
% coe   = weighting of the velocity from each rule
% prd= predator flag
% prdSpd   = predator speed
% vLim= velocity limit for the boids
% vCorr  = velocity correction for the boids leaving bounds
% pltFov = zor and fov plotting flag
% arr = arrowd plotting flag
% figNo  = number of figure to avoid superposition
%
% OUTPUTS:
% plot of the desired simulation case setup
% 
% Xing Jin and Javier Lobato, created on 2018/04/03

% Initialize position and velocity of the flock
[boid,pred] = initialization(dim,n,prd);

% Create a new figure to avoid superposition
figure(figNo)

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
    boid = updateboid(dim,n,boid,prd,pred,coe,zor,zop,fov,vLim,vCorr);
        % If there is a predator, also update it
        if prd
             pred = updatepred(dim,n,boid,pred,prdSpd);
        end
    % Plot current position of boids and predator
    pltdistribution(dim,boid,prd,pred,arr,pltFov, zor, fov,ind)
    % Pause to see the figure
    pause(0.001)
end

end

