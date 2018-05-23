% Let's clean the environment and define the variables
clear all, close all, clc
runs = 5;
focus = 20;
dim = 201;
time = 101;

%%
% Calling to the program and evaluation of the system
EVFO = zeros([focus, runs, 4,time]);
locTime = zeros([focus, runs, focus, 3]);

for i=1:focus
    for j=1:runs
        [EVFO(i,j,:,:), locTime(i,j,1:i,1:2), locTime(i,j,1,3)] = fireSpread(dim, 0.8, 0.6, 0.7, time-1, i, 'toroidal', 'async');    
    end
    close all; % Close the figures from time to time
end    
close all;

%%
% Statistical computations for state cell fractions 
statisticalFractions = zeros([focus,2,4,time]); %Representing: number of focus, mean-std, states, time

for i=1:focus
    for j=1:4
        for k=1:time
            statisticalFractions(i, 1, j, k) = mean(EVFO(i, :, j, k));
            statisticalFractions(i, 2, j, k) = std(EVFO(i, :, j, k));
        end
    end
end

% Statistical computations for times
statisticalTimes = zeros([focus, 2]); %number of focus, mean-std

for i=1:focus
    statisticalTimes(i,1) = mean(locTime(i,:,1,3));
    statisticalTimes(i,2) = std(locTime(i,:,1,3));
end

%%
% Plotting of the evolution in time of the percentage of state-cells
figNo = 1;
x = linspace(0,time, time);

for i=1:focus
    for j=1:runs
        figure(figNo)
        hold on
            plot(x, reshape(EVFO(i,j,1,:)./dim^2, [time, 1]), 'ks-','MarkerFaceColor','k','Markersize',5)
            plot(x, reshape(EVFO(i,j,2,:)./dim^2, [time, 1]), 'gv-','MarkerFaceColor','g','Markersize',5)
            plot(x, reshape(EVFO(i,j,3,:)./dim^2, [time, 1]), 'ro-','MarkerFaceColor','r','Markersize',5)
            plot(x, reshape(EVFO(i,j,4,:)./dim^2, [time, 1]), '^-', 'Color', [0.4, 0.4, 0.4],'MarkerFaceColor',[0.4, 0.4, 0.4],'Markersize',5)
        hold off
    end
    ley = legend('Empty cells','Vegetation cells','Fire cells','Burnt cells','Location','east');
    set(ley,'FontSize',14)
    xlabel('Iteration','FontSize',18)
    ylabel('Percentage of each state','FontSize',18)
    title(['Simulation with ', num2str(i), ' initial fires'],'FontSize',24)
    xlim([0,time-1])
    set(gcf, 'Position', [0 0 1000 600])
    saveas(gcf,['PML',num2str(i),'.png'])
    figNo = figNo+1;
end

%%
% Plotting of mu-std of the evolution in time of the percentage of state-cells 
for i=1:focus
    for j=1:runs
        figure(figNo)
        hold on
            errorbar(x, reshape(statisticalFractions(i, 1, 1, :)./dim^2, [time,1]), reshape(statisticalFractions(i, 2, 1, :)./dim^2, [time,1]), 'ks-','MarkerFaceColor','k','Markersize',5)
            errorbar(x, reshape(statisticalFractions(i, 1, 2, :)./dim^2, [time,1]), reshape(statisticalFractions(i, 2, 2, :)./dim^2, [time,1]), 'gv-','MarkerFaceColor','g','Markersize',5)
            errorbar(x, reshape(statisticalFractions(i, 1, 3, :)./dim^2, [time,1]), reshape(statisticalFractions(i, 2, 3, :)./dim^2, [time,1]), 'ro-','MarkerFaceColor','r','Markersize',5)
            errorbar(x, reshape(statisticalFractions(i, 1, 4, :)./dim^2, [time,1]), reshape(statisticalFractions(i, 2, 4, :)./dim^2, [time,1]), '^-', 'Color', [0.4, 0.4, 0.4],'MarkerFaceColor',[0.4, 0.4, 0.4],'Markersize',5)
            hold off
        xlim([0,time-1])
    end
    ley = legend('Empty cells','Vegetation cells','Fire cells','Burnt cells','Location','east');
    set(ley,'FontSize',14)
    xlabel('Iteration','FontSize',18)
    ylabel('Percentage of each state','FontSize',18)
    title(['Simulation with ', num2str(i), ' initial fires - Mean and standard deviation'],'FontSize',24)
    xlim([0,time-1])
    set(gcf, 'Position', [0 0 1000 600])
    saveas(gcf,['PML_mu_sigma_',num2str(i),'.png'])
    figNo = figNo+1;
end

%%
% Burning time depending on the number of initial fires
focusVec = linspace(1,focus,focus);
figure(figNo)
hold on
for i=1:focus
    for j=1:runs
        errorbar(i,statisticalTimes(i,1),statisticalTimes(i,2),'b','LineWidth',1.2)
    end
end
plot(focusVec, statisticalTimes(:,1),'b','LineWidth',2)
hold off
xlim([0,focus+1])
xlabel('Number of initial fires','FontSize',18)
ylabel('Burning time','FontSize',18)
title(['Burning time depending on the number of initial fires'],'FontSize',24)
set(gcf, 'Position', [0 0 1000 600])
saveas(gcf,['asymptoticBehavior.png'])
figNo = figNo + 1;

%%
% Normalized burning profiles
figure(figNo)
% plotStyle = {'s--','o:','h-','^-.','d:','x--','v-','+-.'}; %report
plotStyle = {'-','-','-','-','-','-','-','-'}; %beamer
c = flipud(winter(8));

hold on
counter = 1;
for i=[1,2,3,4,5,10,15,20]
    plot(x/find(statisticalFractions(i, 1, 3, :)==0, 1, 'first'), reshape(statisticalFractions(i, 1, 3, :)./dim^2, [time,1]), plotStyle{counter},'Color',c(counter,:),'LineWidth',1,'MarkerFaceColor',c(counter,:))
    legendList{counter} = [num2str(i),' initial fires ']; 
    counter = counter + 1;
end
hold off
ley = legend(legendList);
set(ley,'FontSize',14)
xlim([0,1])
xlabel('Normalized burning time','FontSize',18)
ylabel('Percentage of fire cells','FontSize',18)
title(['Normalized burning profiles'],'FontSize',24)
set(gcf, 'Position', [0 0 1000 600])
saveas(gcf,['burningProf.png'])