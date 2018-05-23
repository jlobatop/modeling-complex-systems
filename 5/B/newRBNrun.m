function [inputs,rules,statematrix]=newRBNrun(N,K,maxit,p)
% RBN driver: creates a new NK-RBN with specified p, runs it for maxit its from a random I.C., and displays results
% [inputs,rules,statematrix]=newRBNrun(N,K,maxit,p)
%
% INPUT PARAMETERS
% N: number of nodes, it must be larger than K
% K: constant in-degree for each node
% maxit: number of timesteps to run (1 if not specified)
% p: probability of ones in each output function (optional: default = 0.5)
%
% OUTPUT PARAMETERS:
% inputs: cell array with N elements, each one with a length given by a
%       Poisson distribution (with value k)
% rules: cell array for each individual, with a 2^length(real<K>) for each
%       individual in the network, storing a boolean variable
% statematrix: maxit X N with the states of the RBN in time

% AUTHOR: Maggie Eppstein

if nargin < 4
    p=0.5; %default prob of 1's
end

startstate=rand(1,N)<0.5; % Create a random initial condition
[inputs,rules]=makeRBN(N,K,p); % Create new NK-RBN
statematrix=evolveRBN(inputs,rules,startstate,maxit); % Evolve the RBN
