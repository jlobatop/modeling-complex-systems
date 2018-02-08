%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                              HOMEWORK #1.B                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%This code was originally downloaded from the following web site
%   http://courses.cit.cornell.edu/bionb441/LSystem/index.html
%
%Given by Margaret Eppstein for the course 
%    CSYS 302 'Modeling Complex Systems'
%
%Modified by Javier Lobato (02/08/2018)

%% BUSH-2 Figure 6.6
clear all

%axiom
axiom = 'F';

%mode selection: 'stoc' or 'nonStoc'
mode = 'nonStoc';

%set of rules
rule(1).before = 'F';
rule(1).after = '|[+F]|[-F]+F';

%number of repetitions
nReps = 5;

%calculation of the 
[resultingString, depthLevel] = LsysExpandB(nReps, axiom, rule, mode);

%plot parameters definition
plotParameters = struct('length', cell(1, 1), 'color', cell(1, 1),'delta',cell(1,1));

plotParameters(1).length = 0.65; %length of case F
plotParameters(1).color = [0.30 0.62 0.30]; %dark green to the bush
plotParameters(1).delta = 20;

%turtle graphic plotter
LsysDrawB(resultingString, depthLevel, plotParameters, 'Bush-2 (Figure 6.6) - Javier Lobato', 1);


%% TREE-2 Figure 6.7
clear all

%axiom
axiom = 'F';

%mode selection: 'stoc' or 'nonStoc'
mode = 'nonStoc';

%set of rules
rule(1).before = 'F';
rule(1).after = '|[5+F][7-F]-|[4+F][6-F]-|[3+F][5-F]-|F';

%number of repetitions
nReps = 4;

%string calculation
[resultingString, depthLevel] = LsysExpandB(nReps, axiom, rule, mode);

%plot parameters definition
plotParameters = struct('length', cell(1, 1), 'color', cell(1, 1),'delta',cell(1,1));

plotParameters(1).length = 0.4; %length of case F
plotParameters(1).color = [0.13 0.55 0.13]; %forest green for the tree
plotParameters(1).delta = 8;

%turtle graphic plotter
LsysDrawB(resultingString, depthLevel, plotParameters, 'Tree-2 (Figure 6.7) - Javier Lobato', 2);

%% Triangular fractal
clear all

%axiom
axiom = 'F';

%mode selection: 'stoc' or 'nonStoc'
mode = 'nonStoc';

%set of rules
rule(1).before = 'F';
rule(1).after = 'G|25+|F';
rule(2).before = 'G';
rule(2).after = '[3-G]';

%number of repetitions
nReps = 5;

%string calculation
[resultingString, depthLevel] = LsysExpandB(nReps, axiom, rule, mode);

%plot parameters definition
plotParameters = struct('length', cell(2, 1), 'color', cell(2, 1));

plotParameters(1).length = 0.7; %length of case F
plotParameters(2).length = 0.15; %length of case G
plotParameters(1).color = [0.5 0.3 0.0]; %brown (F)
plotParameters(2).color = [0.0 1.0 0.0]; %green (G)
plotParameters(1).delta = 5;

%turtle graphic plotter
LsysDrawB(resultingString, depthLevel, plotParameters, 'Triangular fractal - Javier Lobato', 3);

%% Stochastic tree
clear all

%axiom
axiom = 'F';

%mode selection: 'stoc' or 'nonStoc'
mode = 'stoc';

%set of rules
rule(1).before = 'F';
rule(1).after = 'F+[-F+F-G]';
rule(1).prob = 0.3;
rule(2).before = 'F';
rule(2).after = 'F-[G2+F]';
rule(2).prob = 0.3;
rule(3).before = 'F';
rule(3).after = 'F-[F+G]+[-F2+F-F+G]';
rule(3).prob = 0.4;
rule(4).before = 'G';
rule(4).after = '[+M][2-N][-M]';
rule(4).prob = 0.25;
rule(5).before = 'G';
rule(5).after = '[2-MN]';
rule(5).prob = 0.25;
rule(6).before = 'G';
rule(6).after = '[N2-M]';
rule(6).prob = 0.25;
rule(7).before = 'G';
rule(7).after = '[N-N-N]';
rule(7).prob = 0.25;

%number of repetitions
nReps = 5;

%plot parameters definition
plotParameters = struct('length', cell(4, 1), 'color', cell(4, 1), 'delta', cell(1, 1));

plotParameters(1).length = 0.5; %length of case F
plotParameters(2).length = 0.025; %length of case G
plotParameters(3).length = 0.025; %length of case M
plotParameters(4).length = 0.025; %length of case N
plotParameters(1).color = [0.5 0.3 0.0]; %brown (case F)
plotParameters(2).color = [0.0 0.81 0.0]; %darker green (case G)
plotParameters(3).color = [0.13 0.55 0.13]; %forest green (case M)
plotParameters(4).color = [0.0 1.0 0.0]; %green (case N)
plotParameters(1).delta = 10;

%let's generate various plot to demonstrate the randomness of the model
for i = 1:4
    %string calculation for each repetition
    [resultingString, depthLevel] = LsysExpandB(nReps, axiom, rule, mode);
  
    %turtle graphic plotter
    LsysDrawB(resultingString, depthLevel, plotParameters, sprintf('Stochastic tree - Run %i - Javier Lobato', i), i+3);
end

