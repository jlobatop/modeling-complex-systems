function [statematrix]=evolveRBN(inputs,rules,startstates,maxit)
% evolveRBN: evolves a RBN certain number of maxit timesteps
% function [statematrix]=evolveRBN(inputs,rules,startstates,maxit)
%
% INPUT PARAMETERS
% inputs: K rows X N column matrix of integers in range [1..N]
%           (each column holds indeces of which nodes point to that node)
% rules: cell array for each individual, with a 2^length(real<K>) for each
%       individual in the network, storing a boolean variable
% startstates: 1 X N binary vector of initial condition
% maxit: number of iterations (optional: default is 1)
%
% OUTPUT PARAMETER:
% statematrix: maxit X N with states along timesteps

% Author: Maggie Eppstein
% MODIFIED BY: Javier Lobato 05/02/2018 (adaptation to use Poisson indegree
%       distributed Random Boolean Networks)

% Set number of iteratiosn to 1 if it is not specified
if nargin < 4
    maxit = 1; 
end

% Preallocate the output matrix for increase efficiency
statematrix=zeros(maxit+1,size(startstates,2));

% Assign the initial states to the state matrix in the first position
statematrix(1,:)=startstates;

% Loop over desired timesteps
for t=1:maxit
    % Loop over every element of the network
    for n=1:length(inputs)
        % Compute the index of the rule that must be applied depending on
        % the value of the correspondant index in the previous timestep
        index = bi2de(fliplr(statematrix(t,inputs{n})))+1;
        % Assign the new state into the state matrix
        statematrix(t+1,n)=rules{n}(index);
    end
end