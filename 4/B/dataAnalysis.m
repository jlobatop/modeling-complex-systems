%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                              HOMEWORK #4.B                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Javier Lobato, created on 2018/04/15
close all; clear all; clc;

%% Parameter sweep of the k-nearest neighbors
% Case variables
n = 50; dim = 200; ts = 100; 
% Bird configuration
zor = 2; zop = 20; fov = 0.8*pi; vLim = 30; vCorr = 3; 
coe = [1/100,1,1/8,1]; 
% Predator configuration
prd = false; prdSpd = 0;
% Plotting configurationc
plop = true; arrows = false; pltFov = false; figNo = 1;
% Mode of vision
visionMode = [false, true, true];
% Parameter sweep vector
k = [1,5,10,15,20];
% Number of runs
runs = 10;
% Maximum diameter for this parameter sweep
diam = zeros([length(k),runs,ts+1]);
% Function calling 
for j=1:length(k)
    for i=1:runs
        diam(j,i,:) = swarmModel(n,dim,ts,zor,zop,fov,k(j),coe,prd,prdSpd,vLim,vCorr,plop,pltFov,arrows,figNo,visionMode);
    end
end    

figure(2)
% Plot the mean and standard deviation for k-neearest parameter sweep
c = (winter(length(k)));
lw = ['-o','-v','-h','-h','-^','-v'];
hold on
for j=1:length(k)
    errorbar(0:1:100,reshape(mean(diam(j,:,:)/sqrt(2*dim^2),2),[1,101]),reshape(std(diam(j,:,:)/sqrt(2*dim^2)),[1,101]),lw(j),'Color',c(j,:),'MarkerFaceColor',c(j,:))
    legendList{j} = ['k = ',num2str(k(j))]; 
end
hold off
ylim([0,1])
ley = legend(legendList);
set(ley,'FontSize',14);
xlabel('Timesteps')
ylabel('Normalized maximum size of the flock')
set(gca,'FontSize',14)
title(['k variation'],'FontSize',20)

%% Parameter sweep of the field of vision 
% Case variables
n = 50; dim = 200; ts = 100; 
% Bird configuration
zor = 2; zop = 20; k = 6; vLim = 30; vCorr = 3; 
coe = [1/100,1,1/8,1]; 
% Predator configuration
prd = false; prdSpd = 0;
% Plotting configurationc
plop = true; arrows = false; pltFov = false; figNo = 1;
% Mode of vision
visionMode = [false, true, true];
% Parameter sweep vector
fov = [0.2*pi,0.4*pi,0.6*pi,0.8*pi,1.0*pi,1.2*pi];
% Number of runs
runs = 10;
% Maximum diameter for this parameter sweep
diam = zeros([length(k),runs,ts+1]);
% Function calling 
for j=1:length(fov)
    for i=1:runs
        diam(j,i,:) = swarmModel(n,dim,ts,zor,zop,fov(j),k,coe,prd,prdSpd,vLim,vCorr,plop,pltFov,arrows,figNo,visionMode);
    end
end    
 
figure(3)
% Plot the mean and standard deviation for field of view parameter sweep
c = (winter(length(fov)));
lw = ['-o','-v','-h','-h','-^','-v'];
hold on
for j=1:length(fov)
    errorbar(0:1:100,reshape(mean(diam(j,:,:)/sqrt(2*dim^2),2),[1,101]),reshape(std(diam(j,:,:)/sqrt(2*dim^2)),[1,101]),lw(j),'Color',c(j,:),'MarkerFaceColor',c(j,:))
    legendList{j} = ['fov = ',num2str(fov(j)/pi),'? rad']; 
end
hold off
ylim([0,1])
ley = legend(legendList);
set(ley,'FontSize',14);
xlabel('Timesteps')
ylabel('Normalized maximum size of the flock')
set(gca,'FontSize',14)
title(['Field of view variation'],'FontSize',20)

%% Parameter sweep of the size of the zone of repulsion 
% Case variables
n = 50; dim = 200; ts = 100; 
% Bird configuration
zop = 20; fov = 0.8*pi; k = 6; vLim = 30; vCorr = 3; 
coe = [1/100,1,1/8,1]; 
% Predator configuration
prd = false; prdSpd = 0;
% Plotting configurationc
plop = true; arrows = false; pltFov = false; figNo = 1;
% Mode of vision
visionMode = [false, false, true];
% Parameter sweep vector
zor = [1,2,3,4,5];
% Number of runs
runs = 10;
% Maximum diameter for this parameter sweep
diam = zeros([length(k),runs,ts+1]);
% Function calling 
for j=1:length(zor)
    for i=1:runs
        diam(j,i,:) = swarmModel(n,dim,ts,zor(j),zop,fov,k,coe,prd,prdSpd,vLim,vCorr,plop,pltFov,arrows,figNo,visionMode);
    end
end    

figure(4)
% Plot the mean and standard deviation for zone of repulsion parameter sweep
c = (winter(length(zor)));
lw = ['-o','-v','-h','-h','-^'];
hold on
for j=1:length(zor)
    errorbar(0:1:100,reshape(mean(diam(j,:,:)/sqrt(2*dim^2),2),[1,101]),reshape(std(diam(j,:,:)/sqrt(2*dim^2)),[1,101]),lw(j),'Color',c(j,:),'MarkerFaceColor',c(j,:))
    legendList{j} = ['zor = ',num2str(zor(j))]; 
end
hold off
ylim([0,1])
ley = legend(legendList);
set(ley,'FontSize',14);
xlabel('Timesteps')
ylabel('Normalized maximum size of the flock')
set(gca,'FontSize',14)
title(['Zone of repulsion variation'],'FontSize',20)