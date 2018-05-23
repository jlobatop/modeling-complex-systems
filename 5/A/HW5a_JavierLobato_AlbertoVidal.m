%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                              HOMEWORK #5.A                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Javier Lobato & Alberto Vidal, created on 2018/04/22

% Let's clear the environment
clear all; clc; close all;

% Definition of the number of runs for each set
runNo = 200;

%% Probability of 0.2

% Number of elements in the RBN
N = 2000;
% Probability
p = 0.2;
% Average indegree number of the nodes
K = [1, 2, 3];

% Calling to the function
p02k1 = runRBN(N, K(1), p, 500, runNo);
p02k2 = runRBN(N, K(2), p, 200, runNo);
p02k3 = runRBN(N, K(3), p, 500, runNo);

%% Plotting of the probability of 0.2

% Computation of the slopes of the lines
pf1 = polyfit(linspace(0,0.01,0.01*N+1)', p02k1(1:0.01*N+1),1);
pf2 = polyfit(linspace(0,0.01,0.01*N+1)', p02k2(1:0.01*N+1),1);
pf3 = polyfit(linspace(0,0.01,0.01*N+1)', p02k3(1:0.01*N+1),1);

% Lambda value calculation
lambda = log(2*p*(1-p).*K);

% Figure declaration and plotting
figure(1)
hold on 
plot(linspace(0,1,N+1), p02k1, 'go-', 'MarkerFaceColor', 'g')
plot(linspace(0,1,N+1), p02k2, 'bs-', 'MarkerFaceColor', 'b')
plot(linspace(0,1,N+1), p02k3, 'rd-', 'MarkerFaceColor', 'r')
plot([0,0.01],[0,0.01],'k--', 'Linewidth', 2)
plot([0,0.1],[0,0.1*pf1(1)] ,'g:', 'Linewidth',1.5)
plot([0,0.1],[0,0.1*pf2(1)] ,'b:', 'Linewidth',1.5)
plot([0,0.1],[0,0.1*pf3(1)] ,'r:', 'Linewidth',1.5)
hold off

% Forcing ticks to certain position
xticks([0.0, 0.002, 0.004, 0.006, 0.008, 0.01])
yticks([0.0, 0.005, 0.01, 0.015, 0.02, 0.025, 0.03, 0.035])
set(gca, 'FontSize', 16)

% Legend
len = legend(['K=1, slope=', num2str(pf1(1),2),', \lambda = ', num2str(lambda(1),3)], ...
             ['K=2, slope=', num2str(pf2(1),2),', \lambda = ', num2str(lambda(2),3)], ...
             ['K=3 , slope=', num2str(pf3(1),2),', \lambda = ', num2str(lambda(3),3)], ...
              'K_{crit}', 'Location', 'northwest');
set(len, 'FontSize',18)

% Labeling of axis and title
xlabel('Normalized Haming Distance (t)', 'FontSize',18)
ylabel('Normalized Haming Distance (t+1)', 'FontSize',18)
titletex = ['Probability = ', num2str(p)];
title(titletex, 'Fontsize', 22);
xlim([0,0.01])
ylim([0,0.035])

%% Probability of 0.5

% Number of elements in the RBN
N = 2000;
% Probability
p = 0.5;
% Average indegree number of the nodes
K = [1, 2];

% Calling to the function
p05k1 = runRBN(N, K(1), p, 500, runNo);
p05k2 = runRBN(N, K(2), p, 200, runNo);

%% Plotting of the probability of 0.5

% Computation of the slopes of the lines
pf1 = polyfit(linspace(0,0.01,0.01*N+1)', p05k1(1:0.01*N+1),1);
pf2 = polyfit(linspace(0,0.01,0.01*N+1)', p05k2(1:0.01*N+1),1);

% Lambda value calculation
lambda = log(2*p*(1-p).*K);

% Figure declaration and plotting
figure(2)
hold on 
plot(linspace(0,1,N+1), p05k1, 'go-', 'MarkerFaceColor', 'g')
plot(linspace(0,1,N+1), p05k2, 'bs-', 'MarkerFaceColor', 'b')
plot([0,0.01],[0,0.01],'k--', 'Linewidth', 2)
plot([0,0.1],[0,0.1*pf1(1)] ,'g:', 'Linewidth',1.5)
plot([0,0.1],[0,0.1*pf2(1)] ,'b:', 'Linewidth',1.5)
hold off

% Forcing ticks to certain position
xticks([0.0, 0.002, 0.004, 0.006, 0.008, 0.01])
yticks([0.0, 0.01, 0.02, 0.03, 0.04, 0.05])
xlim([0,0.01])
ylim([0,0.05])
set(gca, 'FontSize', 16)

% Legend
len = legend(['K=1, slope=', num2str(pf1(1),2),', \lambda = ', num2str(lambda(1),3)], ...
             ['K=2, slope=', num2str(pf2(1),2),', \lambda = ', num2str(lambda(2),3)], ...
              'K_{crit}', 'Location', 'northwest');
set(len, 'FontSize',18)

% Labeling of axis and title
xlabel('Normalized Haming Distance (t)', 'FontSize',18)
ylabel('Normalized Haming Distance (t+1)', 'FontSize',18)
titletex = ['Probability = ', num2str(p)];
title(titletex, 'Fontsize', 22);

%% Probability of 0.8

% Number of elements in the RBN
N = 2000;
% Probability
p = 0.8;
% Average indegree number of the nodes
K = [1, 2, 3];

% Calling to the function
p08k1 = runRBN(N, K(1), p, 500, runNo);
p08k2 = runRBN(N, K(2), p, 200, runNo);
p08k3 = runRBN(N, K(3), p, 500, runNo);

%% Plotting of the probability of 0.8

% Computation of the slopes of the lines
pf1 = polyfit(linspace(0,0.01,0.01*N+1)', p08k1(1:0.01*N+1),1);
pf2 = polyfit(linspace(0,0.01,0.01*N+1)', p08k2(1:0.01*N+1),1);
pf3 = polyfit(linspace(0,0.01,0.01*N+1)', p08k3(1:0.01*N+1),1);

% Lambda value calculation
lambda = log(2*p*(1-p).*K);

% Figure declaration and plotting
figure(3)
hold on 
plot(linspace(0,1,N+1), p08k1, 'go-', 'MarkerFaceColor', 'g')
plot(linspace(0,1,N+1), p08k2, 'bs-', 'MarkerFaceColor', 'b')
plot(linspace(0,1,N+1), p08k3, 'rd-', 'MarkerFaceColor', 'r')
plot([0,0.01],[0,0.01],'k--', 'Linewidth', 2)
plot([0,0.1],[0,0.1*pf1(1)] ,'g:', 'Linewidth',1.5)
plot([0,0.1],[0,0.1*pf2(1)] ,'b:', 'Linewidth',1.5)
plot([0,0.1],[0,0.1*pf3(1)] ,'r:', 'Linewidth',1.5)
hold off

% Forcing ticks to certain position
xticks([0.0, 0.002, 0.004, 0.006, 0.008, 0.01])
yticks([0.0, 0.005, 0.01, 0.015, 0.02, 0.025, 0.03, 0.035])
xlim([0,0.01])
ylim([0,0.035])
set(gca, 'FontSize', 16)

% Legend
len = legend(['K=1, slope=', num2str(pf1(1),2),', \lambda = ', num2str(lambda(1),3)], ...
             ['K=2, slope=', num2str(pf2(1),2),', \lambda = ', num2str(lambda(2),3)], ...
             ['K=3 , slope=', num2str(pf3(1),2),', \lambda = ', num2str(lambda(3),3)], ...
              'K_{crit}', 'Location', 'northwest');
set(len, 'FontSize',18)

% Labeling of axis and title
xlabel('Normalized Haming Distance (t)', 'FontSize',18)
ylabel('Normalized Haming Distance (t+1)', 'FontSize',18)
titletex = ['Probability = ', num2str(p)];
title(titletex, 'Fontsize', 22);

%% Above critical values (K=3 and K=10 for p=0.5)

% Number of elements in the RBN
N = 2000;
% Probability
p = 0.8;

% Calling to the function
p05k3 = runRBN(N, 3, p, 500, runNo);
p05k10 = runRBN(N, 10, p, 200, runNo);

%% Plotting of the above critical values

% Figure declaration and plotting
figure(4)
hold on 
x = [-0.1,0.7];
X=[x,fliplr(x)];
Y=[[-0.1,0.7],fliplr([0.7,0.7])]; 
h = fill(X,Y,[0.9 0.9 0.9]);
set(h,'facealpha',.5)
plot(linspace(0,1,N+1), p05k3, 'ro', 'MarkerFaceColor', 'r')
plot(linspace(0,1,N+1), p05k10, 'ks', 'MarkerFaceColor', 'k')
plot([0,0.6],[0,0.6],'k--', 'Linewidth', 2)
plot([0,0.6],[0.5,0.5],'k:', 'Linewidth', 2)
hold off

% Forcing figure limits
xlim([0,0.6])
ylim([0,0.6])
set(gca, 'FontSize', 16)

% Legend
len = legend(['Critical Region'],['K=3'], ['K=10'], ['K_{crit}'], ['Asympt'], ...
              'Location', 'southeast');
set(len, 'FontSize',18)

% Labeling of axis and title
xlabel('Normalized Haming Distance (t)', 'FontSize',18)
ylabel('Normalized Haming Distance (t+1)', 'FontSize',18)
titletex = ['Probability = ', num2str(p)];
title(titletex, 'Fontsize', 22);