function testcase(dim,ts,zor,zop,fov,coe,prd,velLim,vCorr,figNo)
% TESTCASE: function to test some swarm behavior functionalities for a case
% with just 2 boids
%
% INPUTS:
% dim   = size of the domain
% ts    = simulation time
% zor   = radius of the zone of repulsion
% zop   = radius of the zone of predator avoidance
% fov   = field of view angle
% coe   = weighting of the velocity from each rule
% prd   = predator flag
% vLim  = velocity limit for the boids
% vCorr = velocity correction for the boids leaving bounds
% figNo = number of figure to avoid superposition
%
% OUTPUTS:
% Plot with the results of the swarming behavior
% 
% Xing Jin and Javier Lobato, created on 2018/04/03

% Number of boids 2
n = 2;

% Preallocation of boid x-position, y-position, x-velocity and y-velocity
boid = zeros(n,4); 

% Preallocation of pred x-position, y-position, x-velocity and y-velocity
pred = zeros(1,4); 
    
% Angle correction
angle = fov/2;

% Initialization of the boids
boid(1,:) = [dim/2, dim/2, 10^-3, 0];
boid(2,:) = [0, dim/2, 1, 0];

% Create a new figure to avoid superposition
figure(figNo)

% Time loop
for i=1:ts
    % Update boids with the predefined configurations
    boid = updateboid(dim,n,boid,prd,pred,coe,zor,zop,fov,velLim, vCorr);
    % Plot current distribution without the outside function
    % First plot position of boid no. 1
    scatter(boid(1,1),boid(1,2),20,'o','filled','MarkerFaceColor','b')
    % Plot velocity of boid no. 1
    hold on
    quiver(boid(1,1),boid(1,2),boid(1,3),boid(1,4),3,'b');
    % Plot position of boid no. 2
    scatter(boid(2,1),boid(2,2),20,'o','filled','MarkerFaceColor','r')
    % Plot velocity of boid no. 2
    quiver(boid(2,1),boid(2,2),boid(2,3),boid(2,4),3,'r');
    % Zone of repulsion of boid no. 1
    viscircles([boid(1,1) boid(1,2)],zor,...
        'LineStyle',':','color','k','LineWidth',.5);
    % Zone of repulsion of boid no. 2
    viscircles([boid(2,1) boid(2,2)],zor,...
        'LineStyle',':','color','k','LineWidth',.5);
        
    % Field of vision plotting for boids no. 1 and no. 2
    xx = [boid(1,3) boid(1,3)*tan(angle)];
    xx = xx/norm(xx)*zor*1.5;
    yy = [boid(2,3) boid(2,3)*tan(angle)];
    yy = yy/norm(yy)*zor*1.5;
    if fov>pi
        xx = -xx;
        yy = -yy;
    end
    x1 = [boid(1,1) boid(1,1)+xx(1)];
    x2 = [boid(2,1) boid(2,1)+yy(1)];
    y1 = [boid(1,2) boid(1,2)+xx(2)];
    y2 = [boid(1,2) boid(1,2)-xx(2)];
    y3 = [boid(2,2) boid(2,2)+yy(2)];
    y4 = [boid(2,2) boid(2,2)-yy(2)];
    plot(x1,y1,'LineStyle','--','color','k','LineWidth',.5)
    plot(x1,y2,'LineStyle','--','color','k','LineWidth',.5)
    plot(x2,y3,'LineStyle','--','color','k','LineWidth',.5)
    plot(x2,y4,'LineStyle','--','color','k','LineWidth',.5)
    
    % Select axis limits and aspect ratio
    axis([0 dim 7/20*dim 13*dim/20])
    pbaspect([2 1 1])
    set(gca,'FontSize',16)
    hold off
    
    %Pause to see the figure instantaneously
    pause(0.001)
end

end