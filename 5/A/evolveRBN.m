function [statematrix]=evolveRBN(inputs,rules,startstates,maxit)
% evolveRBN: evolves an N-K RBN maxit timesteps; assumes K is constant for each of the N nodes
% function [statematrix]=evolveRBN(inputs,rules,startstates,maxit)
%
% INPUT PARAMETERS
% inputs: K rows X N column matrix of integers in range [1..N]
%           (each column holds indeces of which nodes point to that node)
% rules: 2^K rows by N column binary matrix
%           (each column holds the boolean outputs for each of the 2^K
%           possible inputs, in increasing binary order)
% startstates: 1 X N binary vector of initial condition
% maxit: number of iterations (optional: default is 1)
%
% OUTPUT PARAMETER:
% statematrix: maxit X N

% Author: Maggie Eppstein

persistent N K inputvals coloffsets %persistent means these persist in memory between function calls

if isempty(N) % don't bother to calculate these persistent things more than once
    [K,N]=size(inputs);
    inputvals=[2.^(K-1:-1:0)]; % decimal values of binary inputs
    coloffsets=2^K.*(0:N-1)+1; % 1-D index into 1st row in every col
end

if nargin < 4
    maxit = 1; %default is to evolve only 1 timestep
end

% pre-allocate the statematrix for efficiency
statematrix=zeros(maxit+1,size(startstates,2));
statematrix(1,:)=startstates;

for t=1:maxit
    states=statematrix(t,:);
    
    statematrix(t+1,:)=rules(inputvals*states(inputs)+coloffsets);    
    % THE ABOVE LINE IMPLEMENTS THE EQUIVALENT OF THE FOLLOWING 4 STEPS;
%     inputstates=states(inputs); % get K input states to each node
%     rowindex=inputvals*inputstates; % compute the decimal equivalent of the binary input string
%     ruleindex=rowindex+coloffsets; % convert col indeces into 1-D matrix indeces
%     newstates=rules(ruleindex); % extract the appropriate output values    
end