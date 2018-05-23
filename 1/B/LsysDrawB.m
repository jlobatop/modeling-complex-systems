function [] = LsysDrawB(LsysString, depthLevel, plotParameters, plotTitle, figNo)
% LsysDraw: Draw a string obtained from an L-system with some parameters and
% gives a figure with the specified title. Turtle graphics
%
%INPUTS: 
%LsysString = string that contains the result of the function LsysExpand
%depthLevel = string with the depth in which each element of LsysString has
%   been inserted in the string
%plotParameters = structured array with the length and color of each case
%   and the specified delta angle 
%plotTitle = string that contains the title of the plot
%figNo = will create different figures to avoid them to overwrite
%
%OUTPUTS:
%No other output than the figure
%
%Sample test call: 
%LsysDrawB(LsysString, depthLevel, plotParameters, plotTitle, figNo)
%
%Original code at: http://courses.cit.cornell.edu/bionb441/LSystem/index.html
%Modified by Javier Lobato ans Veronica Saz (02/01/2018)
%Re-modified by Javier Lobato (02/08/2018)

%Initial state (position and angle) of the turtle
xT = 0;
yT = 0;
aT = 0;

%Convert the specified angle to radians
da = deg2rad(plotParameters(1).delta);

%Init the turtle stack with the required preallocation
stack = struct('xT', cell(length(LsysString), 1), 'yT', cell(length(LsysString), 1),'aT', cell(length(LsysString), 1));

%Stack counter definition
stckCounter = 1;

%Variable to add on the cumulative turnings (for the cases with digits)
turnNo = 0;

%Create a figure and keep it open until it is completed
figure(figNo)
hold on

% JL step 5: If the dimension of LsysString doesn't match the dimension of 
% depthLevel, it will exit from the function
if length(LsysString) ~= length(depthLevel)
    display('Bad array input!');
    return
end

for i=1:length(LsysString)
    stringElement = LsysString(i);
    
    %Different case separation
    switch stringElement
    
    %Letter case definition
    case {'F', 'G', 'M', 'N', '|'} %JL step 6: | has been included in the case
        %Assign an index for each letter corresponding to one index of the
        %structured array of the input
        if stringElement == 'F'
            j = 1;
            %JL step 5: F lengths will decrease with depth
            exponent = str2num(depthLevel(i)); 
        elseif stringElement == 'G'
            j = 2;
            %JL step 5: as G lengths will not decrease with depth, the exponent is 1
            exponent = 1; 
        elseif stringElement == 'M'
            j = 3;
            %JL step 5: as M lengths will not decrease with depth, the exponent is 1
            exponent = 1; 
        elseif stringElement == 'N'
            j = 4;
            %JL step 5: as N lengths will not decrease with depth, the exponent is 1
            exponent = 1; 
        elseif stringElement == '|' %JL step 6: F and | will follow the same rules
            j = 1;
            %JL step 5: | lengths will decrease with depth
            exponent = str2num(depthLevel(i)); 
        end
        
        %JL step 5: compute the new location of the X and Y
        newxT = xT + ((plotParameters(j).length)^exponent)*cos(aT);
        newyT = yT + ((plotParameters(j).length)^exponent)*sin(aT);
        plot([yT newyT], [xT newxT],'color',plotParameters(j).color, 'linewidth',2);
        xT = newxT;
        yT = newyT;
    
    case {'X', 'Y'}
        %Do nothing!
              
    case '+' %Clockwise turning angle
        %In case the number is zero (initialization value) it will be one
        %to make a turning equal to delta
        if turnNo == 0
            turnNo = 1;
        end
        aT = aT + turnNo*da; %Multiply the delta angle times the specified digit number
        turnNo = 0; %Assign the value of turnings to zero
    
    case '-' %Counterclockwise turning angle
        %In case the number is zero (initialization value) it will be one
        %to make a turning equal to delta
        if turnNo == 0
            turnNo = 1;
        end
        aT = aT - turnNo*da; %Multiply the delta angle times the specified digit number
        turnNo = 0; %Assign the value of turnings to zero
        
    case '[' %Push the stack with current values
        stack(stckCounter).xT = xT ;
        stack(stckCounter).yT = yT ;
        stack(stckCounter).aT = aT ;
        stckCounter = stckCounter +1 ;
    
    case ']' %Pop the stack taking the last values
        stckCounter = stckCounter-1 ;
        xT = stack(stckCounter).xT ;
        yT = stack(stckCounter).yT ;
        aT = stack(stckCounter).aT ;
    
    case {'0','1','2','3','4','5','6','7','8','9'} %Digit case
        %Takes the digit value 
        turnNo = turnNo + str2num(LsysString(i));
        %Checks the next element of the string. In case it is another
        %digit, it multiplies the value of turnNo by 10 and it will add the
        %next digit in the following for-loop repetition
        if ~mod(str2num(LsysString(i+1)),1) == 1
            turnNo = turnNo*10;
        end
        
    otherwise
            disp('error')
        return
    end
end

hold off

%plot configuration and title
axis equal
title(plotTitle, 'FontSize',16)

end