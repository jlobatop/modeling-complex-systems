function [ResultingString] = LsysExpand(nReps, axiom, rule)
% LsysExpand: Apply a set of rules of an L-system on the input axiom during 
% a specified number of repetitions to give a resulting string
%
%INPUTS: 
%nReps = integer value, number of repetitions of the L-system
%axiom = starting seed for the L-system
%rule = set of rules that define the L-system
%
%OUTPUTS:
%ResultingString = modified string after applying the rules to the axiom 
%
%Sample test call: ResultingString = LsysExpand(nReps, axiom, rule);
%
%Original code at: http://courses.cit.cornell.edu/bionb441/LSystem/index.html
%Modified by Javier Lobato and Veronica Saz

nRules = length(rule); %get the number of rules from the input set

ResultingString = axiom; %copy the axiom to the resulting string 
                         %(for the initialization of the loop)

for i = 1:nReps
    %Convert ResultingString (character vector) to a cell array called RScells
    RScells = cellstr(ResultingString');
    for j = 1:nRules
        %Find occurences of the set of rules in the ResultingString
        hit = strfind(ResultingString, rule(j).before);
        if (length(hit)>=1) %If ocurrences are found
            for k = hit %This will apply each rule to the occurences
                RScells{k} = rule(j).after;
            end
        end
    end
    %Convert RScells from cell array to string
    ResultingString = [RScells{:}]; %No prellocation required
    end
end