%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                              HOMEWORK #4.B                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Javier Lobato, created on 2018/04/15
close all; clear all; clc

% Mode of vision for the flock of birds
% The elements of the vector are:
%    - proximity (circle of repulsion)
%    - field of view (angle of the bird vision)
%    - k-nearest birds (taking into account only the closest birds)

%% Mode of vision: zone of repulsion
% Case variables
n = 200; dim = 200; ts = 1; 
% Bird configuration
zor = 40; zop = 20; fov = 0.4*pi; k = 6; vLim = 20; vCorr = 5; 
coe = [1/100,1,1/8,1]; 
% Predator configuration
prd = false; prdSpd = 0;
% Plotting configuration
plop = true; arrows = false; pltFov = true; figNo = 1;
% Mode of vision
visionMode = [true, false, false];
% Function calling 
swarmModel(n,dim,ts,zor,zop,fov,k,coe,prd,prdSpd,vLim,vCorr,plop,pltFov,arrows,figNo,visionMode);
title('Zone of repulsion');

%% Mode of vision: field of view
% Case variables
n = 200; dim = 200; ts = 1; 
% Bird configuration
zor = 2; zop = 20; fov = 0.6*pi; k = 6; vLim = 20; vCorr = 5; 
coe = [1/100,1,1/8,1]; 
% Predator configuration
prd = false; prdSpd = 0;
% Plotting configuration
plop = true; arrows = false; pltFov = true; figNo = 2;
% Mode of vision
visionMode = [false, true, false];
% Function calling 
swarmModel(n,dim,ts,zor,zop,fov,k,coe,prd,prdSpd,vLim,vCorr,plop,pltFov,arrows,figNo,visionMode);
title('Field of view');

%% Mode of vision: k-nearest neighbors
% Case variables
n = 200; dim = 200; ts = 1; 
% Bird configuration
zor = 2; zop = 20; fov = 0.4*pi; k = 15; vLim = 20; vCorr = 5; 
coe = [1/100,1,1/8,1]; 
% Predator configuration
prd = false; prdSpd = 0;
% Plotting configurationc
plop = true; arrows = false; pltFov = true; figNo = 3;
% Mode of vision
visionMode = [false, false, true];
% Function calling 
swarmModel(n,dim,ts,zor,zop,fov,k,coe,prd,prdSpd,vLim,vCorr,plop,pltFov,arrows,figNo,visionMode);
title('k-nearest neighbors');

%% Mode of vision: zone of repulsion + field of view
% Case variables
n = 200; dim = 200; ts = 1; 
% Bird configuration
zor = 40; zop = 20; fov = 0.6*pi; k = 6; vLim = 20; vCorr = 5; 
coe = [1/100,1,1/8,1]; 
% Predator configuration
prd = false; prdSpd = 0;
% Plotting configurationc
plop = true; arrows = false; pltFov = true; figNo = 4;
% Mode of vision
visionMode = [true, true, false];
% Function calling 
swarmModel(n,dim,ts,zor,zop,fov,k,coe,prd,prdSpd,vLim,vCorr,plop,pltFov,arrows,figNo,visionMode);
title('Zone of repulsion + Field of view');

%% Mode of vision: field of view + k-nearest neighbors
% Case variables
n = 200; dim = 200; ts = 1; 
% Bird configuration
zor = 2; zop = 20; fov = 0.4*pi; k = 10; vLim = 20; vCorr = 5; 
coe = [1/100,1,1/8,1]; 
% Predator configuration
prd = false; prdSpd = 0;
% Plotting configurationc
plop = true; arrows = false; pltFov = true; figNo = 5;
% Mode of vision
visionMode = [false, true, true];
% Function calling 
swarmModel(n,dim,ts,zor,zop,fov,k,coe,prd,prdSpd,vLim,vCorr,plop,pltFov,arrows,figNo,visionMode);
title('Field of view + k-nearest neighbors');
