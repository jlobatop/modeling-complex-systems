%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                              HOMEWORK #5.B                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Javier Lobato, created on 2018/05/01

% Let's clear the environment
clear all; clc; close all;

%% Section 2
% Let's define first the cell array with the individuals
C = cell(3,1);
% Each element i in the cell array contains the individuals that the
% individual i is point towards
C{1} = [2,3];
C{2} = [1,2,3];
C{3} = [1];

% Let's hardcode also the rules for this second section as given for HW5a
rules = cell(3,1);
rules{1} = [0,0,1,1];
rules{2} = [0,0,1,0,1,1,0,1];
rules{3} = [0,1];

% Initial vectors are given directly to the function. Testing one by one 
% all possible inputs to see if the model is correctly working, the state
% matrix will be given as an output
B = zeros([8,2,3]);
B(1,:,:) = evolveRBN(C,rules,[0,0,0]);
B(2,:,:) = evolveRBN(C,rules,[0,0,1]);
B(3,:,:) = evolveRBN(C,rules,[0,1,0]);
B(4,:,:) = evolveRBN(C,rules,[0,1,1]);
B(5,:,:) = evolveRBN(C,rules,[1,0,0]);
B(6,:,:) = evolveRBN(C,rules,[1,0,1]);
B(7,:,:) = evolveRBN(C,rules,[1,1,0]);
B(8,:,:) = evolveRBN(C,rules,[1,1,1]);
% The state matrix for the system (as proposed in the previous assignment)
% is obtained
outputMat = reshape(B(:,2,:),[8,3])


%% SECTION 3 - Computing
% Select the number of times that the case will be run
runs = 100; 
% Select the representative number of individuals
representativeN = [2,5,8,10,20,30,40,50,60,70,80,90,100,125,150,175,200,225,250];
% Select different k values
Kset = [2,5,8];
% Preallocate space to save the values obtained in each simulation
section3 = zeros([length(Kset),length(representativeN),length(runs)]);

% Loop over all values of k
for k=1:length(Kset)
    % Loop over all possible number of individuals
    for N=1:length(representativeN)
        % Repeat the same N-K simulation certain number of times
        for run=1:runs
            % Call the funciton to create a set of N individuals with a
            % target K. Probability value doesn't matter because it only
            % affects the creation of the rules
            ind = makeRBN(representativeN(N),Kset(k),0);
            % Create a variable to store the numbe of connections of each
            % cell (length of each element in the ind{cell array})
            realK = 0;
            % length(ind) = N but for code clarity it is kept the other way
            for i=1:length(ind)
                realK = realK+length(ind{i});
            end
            % Assign the value to the correspondant element in the array
            section3(k,N,run) = realK/length(ind);
        end
    end    
end


%% SECTION 3 - Plotting
% Compute the mean and standard deviation of the data obatined before,
% averaging for all runs
meanS3 = mean(section3,3);
stdS3 = std(section3,[],3);

% Plot the results for all three targeted values of k
subplot(1,3,1)
hold on
errorbar(representativeN,meanS3(1,:),stdS3(1,:),'k','LineWidth',1)
% Line that represents the target k
plot([0,max(representativeN)],[2,2],'r--','LineWidth',2)
hold off
title(['Target <k>=', num2str(Kset(1))])
xlabel('N')
ylabel('<K>')
set(gca, 'FontSize',18)
xlim([0,max(representativeN)])

subplot(1,3,2)
hold on
errorbar(representativeN,meanS3(2,:),stdS3(2,:),'k','LineWidth',1)
% Line that represents the target k
plot([0,max(representativeN)],[5,5],'r--','LineWidth',2)
hold off
title(['Target <k>=', num2str(Kset(2))])
xlabel('N')
ylabel('<K>')
set(gca, 'FontSize',18)
xlim([0,max(representativeN)])

subplot(1,3,3)
hold on
errorbar(representativeN,meanS3(3,:),stdS3(3,:),'k','LineWidth',1)
% Line that represents the target k
plot([0,max(representativeN)],[8,8],'r--','LineWidth',2)
hold off
title(['Target <k>=', num2str(Kset(3))])
xlabel('N')
ylabel('<K>')
set(gca, 'FontSize',18)
xlim([0,max(representativeN)])


%% SECTION 4 - K variation
% Appropiate N value (although higher values give better results)
N = 150;
% Different target K
K1 = 2;
K2 = 5;
K3 = 8;

% Create a representative RBN with desired values
[ind1,~] = makeRBN(N,K1,p1);
[ind2,~] = makeRBN(N,K2,p1);
[ind3,~] = makeRBN(N,K3,p1);

% Preallocate space for data analysis of each RBN
occurencesK1 = zeros([length(ind1),1]);
occurencesK2 = zeros([length(ind2),1]);
occurencesK3 = zeros([length(ind3),1]);

% Loop the individuals matrix to get the length of each individual
for i=1:length(ind1)
    occurencesK1(i) = length(ind1{i});
    occurencesK2(i) = length(ind2{i});
    occurencesK3(i) = length(ind3{i});
end

% Get the correct value of the Poisson distribution for each K
y1 = poisspdf(sort(unique(occurencesK1)),K1);
y2 = poisspdf(sort(unique(occurencesK2)),K2);
y3 = poisspdf(sort(unique(occurencesK3)),K3);

% Plotting the results for each K
subplot(1,3,1)
% The results are normalized to sum 1 (and compare them with true Poisson)
histogram(occurencesK1,sort(unique(occurencesK1))-0.5,...
    'Normalization','probability')
hold on
% Including the correct Poisson distribution
plot(sort(unique(occurencesK1)),y1,'o-','Color',[0.3,0.3,0.3],'Linewidth',1)
hold off
title(['Target <k>=', num2str(K1), '  N=', num2str(N),...
    '  Mean=', num2str(mean(occurencesK1),3)])
xlabel('<K>')
ylabel('Frequency')
set(gca, 'FontSize',16)
subplot(1,3,2)
% The results are normalized to sum 1 (and compare them with true Poisson)
histogram(occurencesK2,sort(unique(occurencesK2))-0.5,...
    'Normalization','probability')
hold on
% Including the correct Poisson distribution
plot(sort(unique(occurencesK2)),y2,'o-','Color',[0.3,0.3,0.3],'Linewidth',1)
hold off
title(['Target <k>=', num2str(K2), '  N=', num2str(N),...
    '  Mean=', num2str(mean(occurencesK2),3)])
xlabel('<K>')
ylabel('Frequency')
set(gca, 'FontSize',16)
subplot(1,3,3)
% The results are normalized to sum 1 (and compare them with true Poisson)
histogram(occurencesK3,sort(unique(occurencesK3))-0.5,...
    'Normalization','probability')
hold on
% Including the correct Poisson distribution
plot(sort(unique(occurencesK3)),y3,'o-','Color',[0.3,0.3,0.3],'Linewidth',1)
hold off
title(['Target <k>=', num2str(K3), '  N=', num2str(N),...
    '  Mean=', num2str(mean(occurencesK3),3)])
xlabel('<K>')
ylabel('Frequency')
set(gca, 'FontSize',16)


%% SECTION 4 - p variation
% Appropiate N value
N = 150;
% Different values of probability to be tested
P1 = 0.2;
P2 = 0.5;
P3 = 0.8;

% Get the rules to each probability with different K
[~,rule1] = makeRBN(N,K2,P1);
[~,rule2] = makeRBN(N,K2,P2);
[~,rule3] = makeRBN(N,K2,P3);
[~,rule4] = makeRBN(N,K3,P1);
[~,rule5] = makeRBN(N,K3,P2);
[~,rule6] = makeRBN(N,K3,P3);

% Preallocation of space for each stored sets of rules
occurencesP1 = zeros([length(rule1),1]);
occurencesP2 = zeros([length(rule2),1]);
occurencesP3 = zeros([length(rule3),1]);
occurencesP4 = zeros([length(rule4),1]);
occurencesP5 = zeros([length(rule5),1]);
occurencesP6 = zeros([length(rule6),1]);

% Get the number of 1's in for each individual normalized with the length 
% of each individual
for i=1:length(rule1)
    occurencesP1(i) = sum(rule1{i})/length(rule1{i});
    occurencesP2(i) = sum(rule2{i})/length(rule2{i});
    occurencesP3(i) = sum(rule3{i})/length(rule3{i});
    occurencesP4(i) = sum(rule4{i})/length(rule4{i});
    occurencesP5(i) = sum(rule5{i})/length(rule5{i});
    occurencesP6(i) = sum(rule6{i})/length(rule6{i});
end

% Plotting the results as histograms
subplot(2,3,1)
% Histograms here are also normalized
histogram(occurencesP1,20,'Normalization','probability')
title(['P=', num2str(P1), '  K=', num2str(K2), '  N=', num2str(N)])
xlabel("Percentage of 1's in the rules")
ylabel('Frequency')
set(gca, 'FontSize',16)
xlim([0,1])
subplot(2,3,2)
% Histogram is normalized
histogram(occurencesP2,20,'Normalization','probability')
title(['P=', num2str(P2), '  K=', num2str(K2), '  N=', num2str(N)])
xlabel("Percentage of 1's in the rules")
ylabel('Frequency')
set(gca, 'FontSize',16)
xlim([0,1])
subplot(2,3,3)
% Histogram is normalized
histogram(occurencesP3,20,'Normalization','probability')
title(['P=', num2str(P3), '  K=', num2str(K2), '  N=', num2str(N)])
xlabel("Percentage of 1's in the rules")
ylabel('Frequency')
xlim([0,1])
set(gca, 'FontSize',16)
subplot(2,3,4)
% Histogram is normalized
histogram(occurencesP4,20,'Normalization','probability')
title(['P=', num2str(P1), '  K=', num2str(K3), '  N=', num2str(N)])
xlabel("Percentage of 1's in the rules")
ylabel('Frequency')
set(gca, 'FontSize',16)
xlim([0,1])
subplot(2,3,5)
% Histogram is normalized
histogram(occurencesP5,20,'Normalization','probability')
title(['P=', num2str(P2), '  K=', num2str(K3), '  N=', num2str(N)])
xlabel("Percentage of 1's in the rules")
ylabel('Frequency')
set(gca, 'FontSize',16)
xlim([0,1])
subplot(2,3,6)
% Histogram is normalized
histogram(occurencesP6,20,'Normalization','probability')
title(['P=', num2str(P3), '  K=', num2str(K3), '  N=', num2str(N)])
xlabel("Percentage of 1's in the rules")
ylabel('Frequency')
xlim([0,1])
set(gca, 'FontSize',16)


%% Probability of 0.2

% Number of runs
runNo = 30;
% Number of elements in the RBN
N = 2000;
% Probability
p = 0.2;
% Average indegree number of the nodes
K = [1, 2, 3];

% Calling to the function
p02k1 = runRBN(N, K(1), p, 100, runNo);
p02k2 = runRBN(N, K(2), p, 100, runNo);
p02k3 = runRBN(N, K(3), p, 100, runNo);

%% Plotting of the probability of 0.2

% Computation of the slopes of the lines
pf1 = polyfit(linspace(0,0.01,0.01*N+1)', p02k1(1:0.01*N+1),1);
pf2 = polyfit(linspace(0,0.01,0.01*N+1)', p02k2(1:0.01*N+1),1);
pf3 = polyfit(linspace(0,0.01,0.01*N+1)', p02k3(1:0.01*N+1),1);

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
xlim([0,0.01])
ylim([0,0.035])
set(gca, 'FontSize', 16)

% Legend
len = legend(['K=1, slope=', num2str(pf1(1),2)], ...
             ['K=2, slope=', num2str(pf2(1),2)], ...
             ['K=3 , slope=', num2str(pf3(1),2)], ...
              'K_{crit}', 'Location', 'northwest');
set(len, 'FontSize',18)

% Labeling of axis and title
xlabel('Normalized Haming Distance (t)', 'FontSize',18)
ylabel('Normalized Haming Distance (t+1)', 'FontSize',18)
titletex = ['Probability = ', num2str(p)];
title(titletex, 'Fontsize', 22);

%% Probability of 0.5

% Number of elements in the RBN
N = 2000;
% Probability
p = 0.5;
% Average indegree number of the nodes
K = [1, 2];

% Calling to the function
p05k1 = runRBN(N, K(1), p, 100, runNo);
p05k2 = runRBN(N, K(2), p, 100, runNo);

%% Plotting of the probability of 0.5

% Computation of the slopes of the lines
pf1 = polyfit(linspace(0,0.01,0.01*N+1)', p05k1(1:0.01*N+1),1);
pf2 = polyfit(linspace(0,0.01,0.01*N+1)', p05k2(1:0.01*N+1),1);

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
len = legend(['K=1, slope=', num2str(pf1(1),2)], ...
             ['K=2, slope=', num2str(pf2(1),2)], ...
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
p08k1 = runRBN(N, K(1), p, 100, runNo);
p08k2 = runRBN(N, K(2), p, 100, runNo);
p08k3 = runRBN(N, K(3), p, 100, runNo);

%% Plotting of the probability of 0.8

% Computation of the slopes of the lines
pf1 = polyfit(linspace(0,0.01,0.01*N+1)', p08k1(1:0.01*N+1),1);
pf2 = polyfit(linspace(0,0.01,0.01*N+1)', p08k2(1:0.01*N+1),1);
pf3 = polyfit(linspace(0,0.01,0.01*N+1)', p08k3(1:0.01*N+1),1);

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
len = legend(['K=1, slope=', num2str(pf1(1),2)], ...
             ['K=2, slope=', num2str(pf2(1),2)], ...
             ['K=3 , slope=', num2str(pf3(1),2)], ...
              'K_{crit}', 'Location', 'northwest');
set(len, 'FontSize',18)

% Labeling of axis and title
xlabel('Normalized Haming Distance (t)', 'FontSize',18)
ylabel('Normalized Haming Distance (t+1)', 'FontSize',18)
titletex = ['Probability = ', num2str(p)];
title(titletex, 'Fontsize', 22);

