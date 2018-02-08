%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                              HOMEWORK #1.A                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%This code was originally downloaded from the following web site
%   http://courses.cit.cornell.edu/bionb441/LSystem/index.html
%
%Given by Margaret Eppstein for the course 
%    CSYS 302 'Modeling Complex Systems'
%
%Modified by Javier Lobato and Veronica Saz

%% WEED 1. Figure 6.5 
clear all

%Axiom
axiom = 'F';

%Set of rules
rule(1).before = 'F';
rule(1).after = 'F[-F]F[+F]F';

%Number of repetitions
nReps = 4;

%String calculation
ResultingString = LsysExpandA(nReps, axiom, rule);

%Plot parameters definition
plotParameters = struct('length', cell(1, 1), 'color', cell(1, 1), 'delta', cell(1, 1));

plotParameters(1).length = 1; %Length of case F
plotParameters(1).color = [0.0 1.0 0.0]; %Green
plotParameters(1).delta = 25;

%Turtle graphic plotter
LsysDrawA(ResultingString, plotParameters, 'Weed-1 (Figure 6.5)', 1);

%% SQUARE-SPIKES. Figure 6.9
clear all

%Axiom
axiom = 'F18-F18-F18-F';

%Set of rules
rule(1).before = 'F';
rule(1).after = 'F17-F34+F17-F';

%Number of repetitions
nReps = 5;

%String calculation
ResultingString = LsysExpandA(nReps, axiom, rule);

%Plot parameters definition
plotParameters = struct('length', cell(1, 1), 'color', cell(1, 1), 'delta', cell(1,1));

plotParameters(1).length = 1; %Length of case F
plotParameters(1).color = [0.0 0.0 0.0]; %Black
plotParameters(1).delta = 5;

%Turtle graphic plotter
LsysDrawA(ResultingString, plotParameters, 'Square-spikes (Figure 6.9)', 2);


%% NATURE INSPIRED FRACTAL
clear all


%Axiom
axiom = 'X9+X9+X9+X9+X9+X9+X9+X9+X9+X9+X9+X9+X9+X9+X9+X9+';

%Set of rules (X and Y will not draw, F-G-M-N will draw)
rule(1).before = 'X';
rule(1).after = '4+F40-GYG40-F68-';

rule(2).before = 'Y';
rule(2).after = '4+M40-N[25+Y]N40-M68-';

%Number of repetitions
nReps = 7;

%String calculation
ResultingString = LsysExpandA(nReps, axiom, rule);

%Plot parameters definition
plotParameters = struct('length', cell(4, 1), 'color', cell(4, 1),'delta',cell(1,1));

plotParameters(1).length = 3; %Length of segment F
plotParameters(2).length = 0.52; %Length of segment G
plotParameters(3).length = 3; %Length of segment M
plotParameters(4).length = 0.52; %Length of segment N
plotParameters(1).color = [1.0 1.0 0.0]; %Yellow color (F)
plotParameters(2).color = [1.0 1.0 0.0]; %Yellow color (G)
plotParameters(3).color = [1.0 0.0 0.0]; %Red color (M)
plotParameters(4).color = [1.0 0.0 0.0]; %Red color (N)
plotParameters(1).delta = 2.5;

%Turtle graphic plotter
LsysDrawA(ResultingString, plotParameters, 'Nature inspired fractal', 3);
