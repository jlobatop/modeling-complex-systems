%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                              HOMEWORK #4.A                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Xing Jin and Javier Lobato, created on 2018/04/03

% Let's clear the environment completely
clear all; clc; close all

%%
% Case 1: swarming behavior and general code testing
% (Variables are described in the function comments)

% Case variables
n = 200; dim = 200; ts = 100; 
% Bird configuration
zor = 4; zop = 20; fov = 2.*pi; vLim = 20; vCorr = 5; 
coe = [1/100,1/2,1/8,0]; 
% Predator configuration
prd = false; prdSpd = 0;
% Plotting configuration
arrows = false; pltFov = false; figNo = 1;
% Function calling for case 1
swarmModel(n,dim,ts,zor,zop,fov,coe,prd,prdSpd,vLim,vCorr,pltFov,arrows,figNo)

%%
% Case 2: implementation of the zone of repulsion and field of view

% Case variables
n = 200; dim = 200; ts = 2; 
% Bird configuration
zor = 30; zop = 20; fov = 0.4*pi; vLim = 20; vCorr = 5; 
coe = [1/100,1,1/8,1]; 
% Predator configuration
prd = false; prdSpd = 0;
% Plotting configuration
arrows = false; pltFov = true; figNo = 2;
% Function calling for case 2
swarmModel(n,dim,ts,zor,zop,fov,coe,prd,prdSpd,vLim,vCorr,pltFov,arrows,figNo)

%%
% Case 3: predator avoidance setup 1 - zone of predator avoidance

% Case variables
n = 500; dim = 200; ts = 20; 
% Bird configuration
zor = 4; zop = 60; fov = 1.8*pi; vLim = 20; vCorr = 5; 
coe = [1/100,1,1/8,1]; 
% Predator configuration
prd = true; prdSpd = 2;
% Plotting configuration
arrows = false; pltFov = false; figNo = 3;
% Function calling for case 3
swarmModel(n,dim,ts,zor,zop,fov,coe,prd,prdSpd,vLim,vCorr,pltFov,arrows,figNo)

%%
% Case 4: predator avoidance setup 2 - arrows implementation

% Case variables
n = 10; dim = 200; ts = 25; 
% Bird configuration
zor = 8; zop = 50; fov = 1.8*pi; vLim = 20; vCorr = 5; 
coe = [1/100,1,1/8,1]; 
% Predator configuration
prd = true; prdSpd = 4;
% Plotting configuration
arrows = true; pltFov = false; figNo = 4;
% Function calling for case 4
swarmModel(n,dim,ts,zor,zop,fov,coe,prd,prdSpd,vLim,vCorr,pltFov,arrows,figNo)

%%
% Case 5: repulsion and field of view extra test

% Case variables
dim = 100; ts = 100; 
% Bird configuration
zor = 10; zop = 35; fov = 0.2*pi; vLim = 20; vCorr = 5; 
coe = [1/100,1/2,1/8,1]; 
% Predator configuration
prd = false; prdSpd = 1;
% No extra plotting configuration due to internal plotting mechanism
figNo = 5;

% Function calling for case 5
testcase(dim,ts,zor,zop,fov,coe,prd,vLim,vCorr,figNo)
