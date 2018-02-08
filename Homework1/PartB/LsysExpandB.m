function [ResultingString, depthLevel] = LsysExpandB(nReps, axiom, rule, mode)
% LsysExpand: Apply a set of rules of an L-system on the input axiom during 
% a specified number of repetitions to give a resulting string
%
%INPUTS: 
%nReps = integer value, number of repetitions of the L-system
%axiom = starting seed for the L-system
%rule = set of rules that define the L-system
%mode = receives the working mode (stochastic or deterministic)
%
%OUTPUTS:
%ResultingString = modified string after applying the rules to the axiom 
%depthLevel = string with the depth in which each value has been inserted
%
%Sample test call: 
%[ResultingString, depthLevel] = LsysExpandB(nReps, axiom, rule, mode);
%
%Original code at: http://courses.cit.cornell.edu/bionb441/LSystem/index.html
%Modified by Javier Lobato and Veronica Saz (02/01/2018)
%Re-modified by Javier Lobato (02/08/2018)

%Get the number of rules from the input set
nRules = length(rule); 

%Copy the axiom to the resulting string, for the initialization of the loop
ResultingString = axiom;
                         
%JL step 6: lets check if the sume of the probabilities is one (for stochastic case)
prob = zeros([1,nRules,nRules]);
if strcmp(mode, 'stoc')
    for i = 1:nRules
        for j = 1:nRules
            %JL step 6: if the rule().before for i and j are the same, the 
            %probability is stored in an array
            if strcmp(rule(i).before, rule(j).before)
                prob(1,j,i) = rule(j).prob;
            end 
        end
    end
    if any(sum(prob)-1) == 1
        %JL step 6: in case the probability doesn't add up to 1 it exits
        disp('Bad probability array')   
        return
    end
end

%JL step 6: get the cumulative sum of the probability matrix
prob = cumsum(prob);
         
%JL step 5: create a string with the length of the axiom replaced with zeros 
depthLevel = num2str(zeros([1,length(axiom)])); 
%JL step 5: given that num2str returns a string with spaces, let's erase them
depthLevel = depthLevel(find(~isspace(depthLevel)));

for i = 1:nReps
    %Convert ResultingString (char) to a cell array called RScells
    RScells = cellstr(ResultingString');
    %JL step 5: convert depthLevel (char) to a cell array called DLcells
    DLcells = cellstr(depthLevel');
    for j = 1:nRules
        %Find occurences of the set of rules in the ResultingString
        hit = strfind(ResultingString, rule(j).before);
        if (length(hit)>=1) %If ocurrences are found
            for k = hit %This will apply each rule to the occurrences
                if strcmp(mode, 'stoc') 
                    %JL step 6: if the mode is stochastic, this will get a 
                    %random value in the matrix (according to their 
                    %probabilities) and apply that rule
                    index = find(rand<prob(:,:,j), 1, 'first');
                    RScells{k} = rule(index).after;
                    %JL step 5: in addition to replacing the value of 
                    %RScells, the same length of characters as rule.after 
                    %but with the numerical value of (depth) will be 
                    %inserted in DLcells
                    DLcells{k} = num2str(i*ones([1,length(rule(index).after)]));
                else
                    %JL step 6: in case the mode is deterministic it will 
                    %apply each rule inside the set
                    RScells{k} = rule(j).after;
                    %JL step 5: in addition to replacing the value of 
                    %RScells, the same length of characters as rule.after 
                    %but with the numerical value of (depth) will be 
                    %inserted in DLcells
                    DLcells{k} = num2str(i*ones([1,length(rule(j).after)]));
                end
            end
        end
    end
    %Convert RScells from cell array to string (no prellocation required)
    ResultingString = [RScells{:}]; 
    %JL step 5: convert DLcells from cell array to string(no prellocation required)
    depthLevel = [DLcells{:}]; 
    %JL step 5: remove the spaces in the string
    depthLevel = depthLevel(find(~isspace(depthLevel))); 
end

end