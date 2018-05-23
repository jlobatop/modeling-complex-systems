function [inputs,rules,statematrix]=newRBNrun(N,K,maxit,p)
% RBN driver: creates a new NK-RBN with specified p, runs it for maxit its from a random I.C., and displays results
% [inputs,rules,statematrix]=newRBNrun(N,K,maxit,p)
%
% INPUT PARAMETERS
% N: number of nodes
% K: constant in-degree for each node
% maxit: number of timesteps to run
% p: probability of ones in each output function (optional: default = 0.5)
%
% OUTPUT PARAMETERS:
% inputs: K rows by N columns 
%           (each column holds indeces of which nodes point to that node)
% rules: 2^K rows by N columns
%           (each column holds the boolean outputs for each of the 2^K
%           possible inputs, in increasing binary order)
% statematrix: maxit X N

% AUTHOR: Maggie Eppstein

if nargin < 4
    p=0.5; %default prob of 1's
end

startstate=rand(1,N)<0.5; %random initial condition
[inputs,rules]=makeRBN(N,K,p); %create new NK-RBN
statematrix=evolveRBN(inputs,rules,startstate,maxit); %run it for maxit timesteps
% plotStates(statematrix); %plot the results
% title(['New RBN: N=',num2str(N),' K=',num2str(K), ' p=',num2str(p)]);
