function pltdistribution(dim,boid,prd,pred,arrow,plotFov, zor, fov,ind)
% PLTDISTRIBUTION: function that plots the position of the boids with a set
% of flags for customization
%
% INPUTS:
% dim     = dimension of the grid
% boid    = boids with position and velocity
% prd     = predator flag
% pred    = predator position and velocity
% arrow   = arrow plotting flag
% plotFov = field of vision/zone of repulsion plotting
% zor     = zone of repulsion radius
% fov     = field of vision angles
% ind     = index of the individual to plot the 'zor' and 'fov' over
%
% OUTPUTS:
% Plot with the results
% 
% Xing Jin and Javier Lobato, created on 2018/04/03


% Delete previous arrows (i.e. annotations)
delete(findall(gcf,'type','annotation'))
% Plot all points with blue circles
scatter(boid(:,1),boid(:,2),...
    10,'o','filled','MarkerFaceColor','b')
% Get the position of the current figure for the arrows
pos = get(gca, 'Position');

% If the zor & fov is wanted to be shown
if plotFov
    % Get a list with all index from 1 to n
    listInd = linspace(1,length(boid),length(boid));
    % Set as empty the index of the individual ind 
    listInd(ind) = [];
    hold on
    % Plot that individual as a blue square to make it bigger
    scatter(boid(ind,1),boid(ind,2),...
        30,'s','filled','MarkerFaceColor','b')
    hold off
    % Get the velocity vector of the individual ind
    vel=(-boid(ind,3:4))';
    % Create and arrow pointing in the direction of individual ind movement
    annotation('arrow', [boid(ind,1)/dim*pos(3) + pos(1),...
     (boid(ind,1)+boid(ind,3))/dim*pos(3) + pos(1)],... 
     [boid(ind,2)/dim*pos(4) + pos(2),...
     (boid(ind,2)+boid(ind,4))/dim*pos(4) + pos(2)],...
     'Color','b');
    % Draw a circle on the zone of repulsion
    th = 0:pi/50:2*pi;
    xunit = zor * cos(th) + boid(ind,1);
    yunit = zor * sin(th) + boid(ind,2);
    hold on
    h = plot(xunit, yunit, '--r');
    hold off
    % Draw two lines that will define the field of vision of the boid
    arc = atan(boid(ind,4)/boid(ind,3));
    % Taking into account the possible returns of the atan function
    if boid(ind,3) > 0
        hold on
        plot([boid(ind,1),boid(ind,1)-dim^2*cos(pi+arc+fov/2)],...
            [boid(ind,2),boid(ind,2)-dim^2*sin(pi+arc+fov/2)],':k')
        plot([boid(ind,1),boid(ind,1)-dim^2*cos(pi+arc-fov/2)],...
            [boid(ind,2),boid(ind,2)-dim^2*sin(pi+arc-fov/2)],':k')
        hold off
    else
        hold on
        plot([boid(ind,1),boid(ind,1)-dim^2*cos(arc+fov/2)],...
            [boid(ind,2),boid(ind,2)-dim^2*sin(arc+fov/2)],':k')
        plot([boid(ind,1),boid(ind,1)-dim^2*cos(arc-fov/2)],...
            [boid(ind,2),boid(ind,2)-dim^2*sin(arc-fov/2)],':k')
        hold off
    end
    % Loop over all the possible individuals except ind
    for i=listInd
        % Compute the vectorial distance from ind to the i-th individual
        dis=boid(ind,1:2)-boid(i,1:2);
        % If the i-th boid is inside the zor
        if abs(norm(dis)) < zor
            % Plot a downwards pointing triangle
            hold on
            scatter(boid(i,1),boid(i,2),...
                25,'v','filled','MarkerFaceColor','k')
            hold off
        end
        % If the i-th boid is inside the field of view
        if acos(dot(dis,vel)/(norm(dis)*norm(vel))) < fov/2
            % Plot an upwards pointing triangle
            hold on
            scatter(boid(i,1),boid(i,2),...
                25,'^','filled','MarkerFaceColor','k')
            hold off
        end
    end
end

% If the arrows are desired
if arrow
    % Loop over all possible boids
    for i=1:length(boid)
        % Plot the arrow as an annotation object
        annotation('arrow', [boid(i,1)/dim*pos(3) + pos(1),...
             (boid(i,1)+boid(i,3))/dim*pos(3) + pos(1)],... 
             [boid(i,2)/dim*pos(4) + pos(2),...
             (boid(i,2)+boid(i,4))/dim*pos(4) + pos(2)],...
             'Color','b');
    end
end
    
% If there is a predator
if prd
    % Plot it as a red square
    hold on
    scatter(pred(1),pred(2),30,'s','filled','MarkerFaceColor','r')
    hold off
    % Plot the arrow of the predator to know where it is pointing
    annotation('arrow', [pred(1)/dim*pos(3) + pos(1),...
         (pred(1)+pred(3))/dim*pos(3) + pos(1)],... 
         [pred(2)/dim*pos(4) + pos(2),...
         (pred(2)+pred(4))/dim*pos(4) + pos(2)],...
         'Color','r');
end

% Fix axis of the plot
axis([0 dim 0 dim])
% Set the fontsize of the axis as 16
set(gca,'FontSize',16)
end