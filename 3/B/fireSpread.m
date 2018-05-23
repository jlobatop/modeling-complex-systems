 function [EVFO, fip, finalT] = fireSpread(dim, D, B, I, maxt, initializationConf, BC, sync_async)
% fireSpread(dim, a, g, maxt, IC, infectionProb, syncOpt, immgrtRate) 
% Implement fire spreading model  with a cellular automata
% based on: R. M. Almeida and E. E. Macau "Stochastic cellular automata 
% model for wildland fire spread dynamics", J. Phys.: Conf. Ser., 2011
%
% MANDATORY INPUTS:
% dim: dimensions of the square map (same dimension for both sides)
% D: probability that represents the heterogeneity of vegetation (D
%       represents full vegetation and (1-D) is an empty forest)
% B: fire length of a cell to go from burning to burnt
% I: ignition probability of a vegetation cell near a burning one
% maxt: maximum number of timesteps to run (user can abort early)
% initializationConf: the possible initial cases are:
%       - vertical firewall
%       - horizontal firewall
%       - fire focus number 
% BC: two possible types: 'absorbing' and 'toroidal'
% sync_async: two possible types of updating: 'synchronous' and
%       'asynchronous'
%
% OUTPUTS: 
% EVFO: number of cells of each possible state for each timestep
% fip: initial position of the fire focus
% finalT: time when the whole forest has been burnt
%
% HIGH-LEVEL ABSTRACT STATES
% E = empty cell without vegetation (0)
% V = vegetation cell (1)
% F = burning cell (2)
% O = burnt cell (3)
% 
% TRANSITION RULES:
% Cell with state E will remain as E (empty cell)
% Cell with state V may go to F if there are F neighbors with a
%       probability I or remain V
% Cell with state F may go to O with a probability B or remain F
% Cell with state O will remain as O
%
% LOW-LEVEL STATES FOR IMPLEMENTATION
% Although the high-level conceptual states are E, V, F, and O, we will 
% actually implement low-level integer states in the range {0,1,2,3,4} 
% The high-level states will then be inferred as follows: 
%	Value of 0 is interpreted as empty (E)
%	Value of 1 is interpreted as vegetation(V)
%	Value of 2 is interpreted as burning (F)
%	Value of 3 is interpreted as burnt (O)
%
% INTERACTION TOPOLOGY: 
% The grid is rectangular with Moore neighborhoods and two kinds of BC.
%
% SYNCHRONOUS VERSION: 
%	Every timestep, update every cell based on values at previous timestep
%
% ASYNCHRONOUS VERSION: 
%	Every timestep, update every cell randomly based on most current values
%   

% STUB MADE BY Maggie Eppstein for the SIR model, 2/24/17
% MODIFIED BY Jack Houk and Javier Lobato for the SIR model, 03/03/2018
% Fire Spread implementation by Javier Lobato, 03/26/2018

% Define state variables to make the code more readable
E = 0;
V = 1;
F = 2;
O = 3;

%Map initialization with a full empty map, adding then random vegetation
map = zeros(dim);
for i=1:dim^2
    if rand() <= D % If the probability is less than D, transform the 
                   % empty from matrix preallocation into vegetation
        map(i) = V;
    end
end



% FIRE INITIALIZATION Initialize the map as stated by the input
if isnumeric(initializationConf) % If a number is specified
    fip = zeros([initializationConf, 2]);
    % Create a random ordered matrix
    orderMatrix = reshape(randperm(floor(dim)^2), [floor(dim),floor(dim)]);
    % And spark the first 'initializationConf' values with an F
    for k=1:initializationConf
        [i,j] = find(orderMatrix == k);
        fip(k, :) = [i,j];
        map(i,j) = F;
    end
elseif strcmp(initializationConf, 'VFirewall') % Vertical firewall
    map(:,floor(rand*dim)) = E;
    map(floor(rand*dim),floor(rand*dim)) = F;
elseif strcmp(initializationConf, 'HFirewall') % Horizontal firewall
    map(floor(rand*dim),:) = E;
    map(floor(rand*dim),floor(rand*dim)) = F;
end

% Preallocation of the output matrix
EVFO = zeros([4, maxt+1]);

% Store the number of susceptible, infected and recovered in the first step
EVFO(1, 1) = sum(sum(map == 0));
EVFO(2, 1) = sum(sum(map == 1));
EVFO(3, 1) = sum(sum(map == 2));
EVFO(4, 1) = sum(sum(map == 3));

% PLOT INITIAL MAP (see function below)
[fighandle,plothandle] = plotMapInNewFigure(map); 

% Synchronous updating case
if strcmp(sync_async, 'sync') 
    % Preallocation of a whole new map to be filled
    newMap = zeros(dim);
    % Loop every iteration time step
    t = 1;
    while sum(sum(map == 2)) ~= 0 %Until the fire is extinguished
        % Loop over the whole map in X and Y 
        for x = 1:dim
            for y = 1:dim
                % Get the eight neighbours of the current cell (x,y)
                % The cardinal coordinates will be used: north, south,
                % east, west - plus their respective combinations
                nn = map(x, abs(mod(y-2, dim))+1);
                ss = map(x, abs(mod(y, dim))+1);
                ww = map(abs(mod(x-2, dim))+1,y);
                ee = map(abs(mod(x, dim))+1,y);
                nw = map(abs(mod(x-2, dim))+1, abs(mod(y-2, dim))+1);
                ne = map(abs(mod(x, dim))+1, abs(mod(y-2, dim))+1);
                sw = map(abs(mod(x-2, dim))+1, abs(mod(y, dim))+1);
                se = map(abs(mod(x, dim))+1, abs(mod(y, dim))+1);

                % Absorbing boundary conditions will assume that in the
                % cells that go outside the grid, the value E will be used
                % x-component (the map is left-right in the x-axis)
                if strcmp(BC, 'absorbing')
                    if x == 1
                        nw = E; ww = E; sw = E;
                    elseif x == dim
                        ne = E; ee = E; se = E;
                    end
                    % y-component
                    if y == 1
                        nw = E; nn = E; ne = E;
                    elseif y == dim
                        sw = E; ss = E; se = E;
                    end
                end    
                % Store the neighbors in a vector
                neighbors = [nn, ne, ee, se, ss, sw, ww, nw];
                 
                % With current cell and neighbor value (apart from other
                % parameters such as the probability of infection, the
                % duration of infection, the duration of recovery, and the
                % immigration rate) the value of the new cell will be
                % computed and stored in the same position in the newMap
                newMap(x,y) = cellUpdate(map(x,y), neighbors, I, B);
            end
        end
        
        % Reassign the newMap to the old variable map
        map = newMap;
        % Store the number of susceptible, infected and recovered
        EVFO(1, t+1) = sum(sum(map == 0));
        EVFO(2, t+1) = sum(sum(map == 1));
        EVFO(3, t+1) = sum(sum(map == 2));
        EVFO(4, t+1) = sum(sum(map == 3));
        
        set(plothandle,'cdata',map); 
        pause(0.01) % Pause to see the map
        
       % Bail out if the user closed the figure (if only the last iteration
       % is wanted, fighandle will not exist
            if ~ishandle(fighandle)
                % Plot the final map and exit the loop
                plotMapInNewFigure(map); 
                title('Final configuration','FontSize', 24)                    
                break
            end 
    t = t + 1; % Add to the next iteration
    end
    EVFO(1, t+1:end) = EVFO(1, t);
    EVFO(2, t+1:end) = EVFO(2, t);
    EVFO(3, t+1:end) = EVFO(3, t);
    EVFO(4, t+1:end) = EVFO(4, t);
    finalT = t+1; 
    
% Asynchronous updating case
else 
    t = 1;
    % Loop every iteration time step
    while sum(sum(map == 2)) ~= 0 
        % A random order or substitution will be determined with randperm
        % that gives a random set of number, using the one-entry mode for a
        % 2D array
        for i = randperm(dim^2) 
            % Converting the one-entry mode for an array into the classical
            % x and y values for a 2D array
            x = 1 + floor((i-1)/dim);
            y = mod((i-1), dim) + 1;
            nn = map(x, abs(mod(y-2, dim))+1);
            ss = map(x, abs(mod(y, dim))+1);
            ww = map(abs(mod(x-2, dim))+1,y);
            ee = map(abs(mod(x, dim))+1,y);
            nw = map(abs(mod(x-2, dim))+1, abs(mod(y-2, dim))+1);
            ne = map(abs(mod(x, dim))+1, abs(mod(y-2, dim))+1);
            sw = map(abs(mod(x-2, dim))+1, abs(mod(y, dim))+1);
            se = map(abs(mod(x, dim))+1, abs(mod(y, dim))+1);

            % Absorbing boundary conditions will assume that in the
            % cells that go outside the grid, the value E will be used
            % x-component (the map is left-right in the x-axis)
            if strcmp(BC, 'absorbing')
                if x == 1
                    nw = E; ww = E; sw = E;
                elseif x == dim
                    ne = E; ee = E; se = E;
                end
                % y-component
                if y == 1
                    nw = E; nn = E; ne = E;
                elseif y == dim
                    sw = E; ss = E; se = E;
                end
            end
            % Store the neighbors in a vector
            neighbors = [nn, ne, ee, se, ss, sw, ww, nw];

            % With current cell and neighbor value (apart from other
            % parameters such as the probability of infection, the
            % duration of infection, the duration of recovery, and the
            % immigration rate) the value of the new cell will be
            % computed and stored in the same position in the newMap
            map(x,y) = cellUpdate(map(x,y), neighbors, I, B);
        end
        % Store the number of susceptible, infected and recovered
        EVFO(1, t+1) = sum(sum(map == 0));
        EVFO(2, t+1) = sum(sum(map == 1));
        EVFO(3, t+1) = sum(sum(map == 2));
        EVFO(4, t+1) = sum(sum(map == 3));
        
        set(plothandle,'cdata',map); 
        pause(0.01) % Pause to see the map
        
       % Bail out if the user closed the figure (if only the last iteration
       % is wanted, fighandle will not exist
            if ~ishandle(fighandle)
                % Plot the final map and exit the loop
                plotMapInNewFigure(map); 
                title('Final configuration','FontSize', 24)                
                break
            end 
    t = t + 1;
    end
    EVFO(1, t+1:end) = EVFO(1, t);
    EVFO(2, t+1:end) = EVFO(2, t);
    EVFO(3, t+1:end) = EVFO(3, t);
    EVFO(4, t+1:end) = EVFO(4, t);
    finalT = t+1;
end   
end

% Updating of the center cell with the neighbors
 function newState = cellUpdate(center, neighbors, I, B)
    % If the center cell is vegetation
    if center == 1
        burningNeighbors = 0;
        % Counting the fire neighbors
        for neighbor = neighbors
            if neighbor == 2
                burningNeighbors = burningNeighbors + 1;
            end
        end
        % Apply the correspondant probability
        if rand < 1-(1-I)^burningNeighbors
            newState = 2; % Vegetation -> Fire
        else
            newState = 1; % Vegetation -> Vegetation
        end
    % If the center cell is fire
    elseif center == 2
        if rand < B
            newState = 3; % Fire -> Burnt
        else
            newState = 2; % Fire -> Fire
        end
    % Otherwise, the cell is empty or already burnt
    else
        newState = center;
    end
 end

% Function to plot the map using imagesc()
function [fighandle,plothandle] = plotMapInNewFigure(map)
    fighandle = figure;
    % Specify location of figure
    set(fighandle,'position',[42   256   560   420]); 
    % Doesn't truncate a row and column like pcolor does
    plothandle = imagesc(map); 
    % Custom colormap definition to show a more real behavior
    customCM = [0.00 0.00 0.00
                0.00 0.98 0.17
                0.95 0.14 0.13
                0.40 0.40 0.40];
    colormap(customCM);
    % Make sure the color limits don't change dynamically
    set(gca,'clim',[0 3]); 
    ch = colorbar;
    set(ch,'Ytick',[0 1 2 3],'Yticklabel',{'Empty', 'Vegetation', 'Fire', 'Burnt'})
    % Make sure aspect ratio is equal
    axis('square') 
end