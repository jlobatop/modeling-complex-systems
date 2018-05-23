 function [SIR] = greenbergHastings(dim, a, g, maxt, initializationConf, infectionProb, sync_async, immigrationRate, saveFigOpt)
% greenbergHastings(dim, a, g, maxt, IC, infectionProb, syncOpt, immgrtRate, saveFigOpt) 
% Implement SIR model in a Cellular Automata
% based on: J. M. Greenberg and S. P. Hastings, "Spatial Patterns for 
% Discrete Models of Diffusion in Excitable Media", SIAM J. Appl. Math., 34:515-523, 1978
%
% MANDATORY INPUTS:
% dim: dimensions of the square map (same dimension for both sides)
% a: duration of infection in an individual
% g: duration of immunity in an individual
% maxt: maximum number of timesteps to run (user can abort early)
% initializationConf: the implemented initial maps are 'case 1' case 2', or
%       a 'random' initialization of the map at iteration = 0
% infectionProb: the probability of infection of a susceptible cell when
%       surrounded by infected cells. If it is 1 the simulation will be
%       deterministic while if infectionProb < 1, a RNG will determine if a
%       cell is infected or not
% sync_async: option with values 'sync' or 'async' to determine the type of
%       map update
% immigrationRate: probability that susceptible cells go randomly infected.
%       If the value is 0, there will not be any susceptible that gets 
%       infected if it is not surrounded by those infected cells
% saveFigOpt: where options are 'saveAll', 'noSave' or 'saveLast' (the last
%       case will only plot the last figure, not showing the others)
%
% OUTPUTS: 
% SIR: a 3-column Matrix with the count of susceptible, infected and
% recovered cells at each timestep[nS,nI,nR]
%
% HIGH-LEVEL ABSTRACT STATES
% S = Susceptible to infection
% I = Infected or infectious 
% R = Recovered from infection
% 
% TRANSITION RULES:
% A cell will remain I for exactly “a” timesteps, becoming then R
% A cell will remain R for exactly “g” timesteps, becoming then S
% With probability p, an I cell can infect a neighbor that is S with an 
%       overall prob of 1-(1-p)^n, if it has n neighbors that are I
%
% LOW-LEVEL STATES FOR IMPLEMENTATION
% Although the high-level conceptual states are S, I, and R, we will 
% actually implement low-level integer states in the range {0,1,…,a+g) 
% The high-level states will then be inferred as follows: 
%	Value of 0 is interpreted as S
%	Values from 1 to a are interpreted as I
%	Values from a+1 to a+g are interpreted as R
% Using this implementation, one can simply increment the low-level values
% for I and R at each timestep, and the value for S when it gets infected
%
% INTERACTION TOPOLOGY: 
% The grid is rectangular with Von Neuman neighborhoods and toroidal BC
%
% SYNCHRONOUS VERSION: 
%	Every timestep, update every cell based on values at previous timestep
% ASYNCHRONOUS VERSION: 
%	Every timestep, update every cell randomly based on most current values
%   

% STUB MADE BY Maggie Eppstein, 2/24/17
%       This stub merely unburdens you from having to figure out how to do
%       the plotting efficiently
% MODIFIED BY Jack Houk and Javier Lobato, 03/03/2018

% Initialize the map with one of the two given cases or with a random map
if strcmp(initializationConf, 'case 1')
    map = zeros(dim);
    map(floor(dim/2)+1, floor(dim/2)+1) = 1;
    map(floor(dim/2)+2, floor(dim/2)+2) = 3;
elseif strcmp(initializationConf, 'case 2')
    map = zeros(dim);
    map(floor(dim/2)+1, floor(dim/2)+1) = 1;
    map(floor(dim/2)+1, floor(dim/2)+2) = 2;
    map(floor(dim/2)+2, floor(dim/2)+2) = 3;
else 
    %Random map initialization
    map = randi([0 a+g], dim, dim); 
end

% Let's use more representative variable name
duration = a; 
recovery = g;

% Preallocation of the output matrix
SIR = zeros([3, maxt+1]);

% Unless only the last map is desired, plot the initial conditions
if ~strcmp(saveFigOpt, 'saveLast')
    [fighandle,plothandle] = plotMapInNewFigure(map,a,g); % Function below
    title('Initial configuration','FontSize', 24)
    pause(0.5) % Pause to see the map
end
    
% If all iterations are wanted, save the initial contidions as 'it0.png'
if strcmp(saveFigOpt, 'saveAll') 
    saveas(gcf,'it0.png')    
% Otherwise, if the last one is wanted AND the maximum time is 0, it will
% be saved (if the maximum time is not zero, it is not the last one)
elseif strcmp(saveFigOpt, 'saveLast') && maxt == 0
    [fighandle,plothandle] = plotMapInNewFigure(map,a,g); 
    title('Initial configuration','FontSize', 24)
    saveas(gcf,'it0.png')    
end

% Store the number of susceptible, infected and recovered
SIR(1, 1) = sum(sum(map == 0));
SIR(2, 1) = sum(sum(map(1 <= map) <= duration));
SIR(3, 1) = sum(sum(duration < map));

% Synchronous updating case
if strcmp(sync_async, 'sync') 
    % Preallocation of a whole new map to be filled
    newMap = zeros(dim);
    % Loop every iteration time step
    for t=1:maxt 
        % Loop over the whole map in X and Y 
        for x = 1:dim
            for y = 1:dim
                % Get the four neighbours of the current cell (x,y)
                upperNeighbor = map(x, abs(mod(y, dim))+1);
                lowerNeighbor = map(x, abs(mod(y-2, dim))+1);
                leftNeighbor = map(abs(mod(x-2, dim))+1,y);
                rightNeighbor = map(abs(mod(x, dim))+1,y);
                % Store the neighbors in a vector
                neighbors = [upperNeighbor, lowerNeighbor, leftNeighbor, rightNeighbor];
                % With current cell and neighbor value (apart from other
                % parameters such as the probability of infection, the
                % duration of infection, the duration of recovery, and the
                % immigration rate) the value of the new cell will be
                % computed and stored in the same position in the newMap
                newMap(x,y) = cellUpdate(map(x,y), neighbors, infectionProb, duration, recovery, immigrationRate);
            end
        end
        % Reassign the newMap to the old variable map
        map = newMap;
        % Store the number of susceptible, infected and recovered
        SIR(1, t+1) = sum(sum(map == 0));
        SIR(2, t+1) = sum(sum(map(1 <= map) <= duration));
        SIR(3, t+1) = sum(sum(duration < map));
        
        % Plot the new map if desired (unless saveFigOpt == 'saveLast')
        if ~strcmp(saveFigOpt, 'saveLast')
            % MUCH faster option than doing a new pcolor!
            set(plothandle,'cdata',map); 
            % Force matlab to show the figure
            figure(gcf),drawnow; 
            % Include the title with the current iteration 
            title(['Iteration ' int2str(t)],'FontSize', 24)
            pause(0.5) % Pause to see the map
        end
        % If all iterations are wanted, save the current plot
        if strcmp(saveFigOpt, 'saveAll') 
            saveas(gcf,['it' int2str(t) '.png'])    
        end
        % If only the last map is wanted (saveFigOpt == 'saveLast') and the
        % current iteration time is the maximum one, save the figure
        if t == maxt && strcmp(saveFigOpt, 'saveLast')
            plotMapInNewFigure(map,a,g); 
            title(['Iteration ' int2str(t)],'FontSize', 24)
            saveas(gcf,['it' int2str(maxt) '.png'])    
        end    
       % Bail out if the user closed the figure (if only the last iteration
       % is wanted, fighandle will not exist
        if ~strcmp(saveFigOpt, 'saveLast')
            if ~ishandle(fighandle)
                % Plot the final map and exit the loop
                plotMapInNewFigure(map,a,g); 
                title('Final configuration','FontSize', 24)
                % Save the last map either if it is the only one to be
                % saved or if all maps have been saved
                if strcmp(saveFigOpt, 'saveAll') || strcmp(saveFigOpt, 'saveLast')
                    saveas(gcf,['it' int2str(maxt) '.png'])    
                end                     
                break
            end 
        end
    end
    
% Asynchronous updating case
else 
    % Loop every iteration time step
    for t=1:maxt      
        % A random order or substitution will be determined with randperm
        % that gives a random set of number, using the one-entry mode for a
        % 2D array
        for i = randperm(dim^2) 
            % Converting the one-entry mode for an array into the classical
            % x and y values for a 2D array
            x = 1 + floor((i-1)/dim);
            y = mod((i-1), dim) + 1;
            % Get the four neighbours of the current cell (x,y)
            upperNeighbor = map(x, abs(mod(y, dim))+1);
            lowerNeighbor = map(x, abs(mod(y-2, dim))+1);
            leftNeighbor = map(abs(mod(x-2, dim))+1,y);
            rightNeighbor = map(abs(mod(x, dim))+1,y);               
            % Store the neighbors in a vector
            neighbors = [upperNeighbor, lowerNeighbor, leftNeighbor, rightNeighbor];
            % With current cell and neighbor value (apart from other 
            % parameters such as the probability of infection, the duration
            % of infection, the duration of recovery, and the immigration 
            % rate) the value of the new cell will be computed and stored 
            % in the same position in the SAME map, so the next value of i
            % will have that updated value
            map(x,y) = cellUpdate(map(x,y), neighbors, infectionProb, duration, recovery, immigrationRate);
        end
        % Store the number of susceptible, infected and recovered
        SIR(1, t+1) = sum(sum(map == 0));
        SIR(2, t+1) = sum(sum(map(1 <= map) <= duration));
        SIR(3, t+1) = sum(sum(duration < map));
        
        % Plot the new map if desired (unless saveFigOpt == 'saveLast')
        if ~strcmp(saveFigOpt, 'saveLast')
            % MUCH faster option than doing a new pcolor!
            set(plothandle,'cdata',map); 
            % Force matlab to show the figure
            figure(gcf),drawnow; 
            % Include the title with the current iteration 
            title(['Iteration ' int2str(t)],'FontSize', 24)
            pause(0.5) % Pause to see the map
        end
        % If all iterations are wanted, save the current plot
        if strcmp(saveFigOpt, 'saveAll') 
            saveas(gcf,['it' int2str(t) '.png'])    
        end
        % If only the last map is wanted (saveFigOpt == 'saveLast') and the
        % current iteration time is the maximum one, save the figure
        if t == maxt && strcmp(saveFigOpt, 'saveLast')
            plotMapInNewFigure(map,a,g); 
            title(['Iteration ' int2str(t)],'FontSize', 24)
            saveas(gcf,['it' int2str(maxt) '.png'])    
        end    
       % Bail out if the user closed the figure (if only the last iteration
       % is wanted, fighandle will not exist
        if ~strcmp(saveFigOpt, 'saveLast')
            if ~ishandle(fighandle)
                % Plot the final map and exit the loop
                plotMapInNewFigure(map,a,g); 
                title('Final configuration','FontSize', 24)
                % Save the last map either if it is the only one to be
                % saved or if all maps have been saved
                if strcmp(saveFigOpt, 'saveAll') || strcmp(saveFigOpt, 'saveLast')
                    saveas(gcf,['it' int2str(maxt) '.png'])    
                end                     
                break
            end 
        end

    end
end   
end
 
 

% The next function will update the value of one target cell, depending on
% the neighbors that cell have, the probability of infection, duration of
% infection, duration of recovery and a possible immigration rate
 function newState = cellUpdate(target, neighbors, infectionProb, duration, recovery, immigrationRate)
    % If target cell is susceptible
    if target == 0
        % A count of the infected neighbors will be performed along the
        % neigbors input vector
        infectedNeighbors = 0;
        for neighbor = neighbors
            if neighbor > 0 && neighbor <= duration
                infectedNeighbors = infectedNeighbors + 1;
            end
        end
        % If there are neighbours surrounding a susceptible kind of cell,
        % it will get infected with some probability
        if rand < 1-(1-infectionProb)^infectedNeighbors
            newState = 1;
        % If it is not surrounded by infected cells, the susceptible cells
        % will keep as susceptible
        else
            newState = 0;
        end
    % If target cell is either infected or recovered
    else
        % The value of the cell will increase in 1 for both cases
        newState = target + 1;
        % If the value exceedes the infection and recovery times, the cell
        % will be turned back into the susceptible type
        if newState == duration + recovery + 1
            newState = 0;
        end
    end
    % If a cell is susceptible and exists an immigration rate
    if newState == 0 && rand < immigrationRate
        % It might get infected randomly
        newState = 1;
    end 
 end

% Function to plot the map using imagesc()
function [fighandle,plothandle] = plotMapInNewFigure(map, a, g)
    fighandle = figure;
    % Specify location of figure
    set(fighandle,'position',[42   256   560   420]); 
    % Doesn't truncate a row and column like pcolor does
    plothandle = imagesc(map); 
    colormap(jet);
    % Make sure the color limits don't change dynamically
    set(gca,'clim',[0 a+g]); 
    ch = colorbar;
    set(ch,'Ytick',[0 a a+g],'Yticklabel',{'S','I up to here','R up to here'})
    % Make sure aspect ratio is equal
    axis('square') 
end