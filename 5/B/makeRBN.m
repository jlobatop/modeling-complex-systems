function [inputs,rules]=makeRBN(N,K,p)
% makes an N-K RBN (i.e., assumes K is constant for each of N nodes)
% function [inputs,rules]=makeRBN(N,K,p); 
%
% INPUT PARAMETERS
% N: number of nodes
% K: average indegree
% p: probability of 1's in the rules
%
% OUTPUT PARAMETERS:
% inputs: cell aray with N elements, each one with the correspondant
%       connections to other individuals in the network
% rules: cell array for each individual, with a 2^length(real<K>) for each
%       individual in the network, storing a boolean variable

% AUTHOR: Maggie Eppstein
% MODIFIED BY: Javier Lobato 05/02/2018 (adaptation to use Poisson indegree
%       distributed Random Boolean Networks)

% Force this function to clear and re-initialize its persistent variables
clear evolveRBN

% If the probability is not specified, set it as 0.5
if nargin < 3
    p=0.5;
end

% INDIVIDUALS CREATION
% Preallocation of the cell array
inputs = cell(N,1);
% Loop over the whole cell array
for node = 1:N
    % Get the number of connections from a Poisson random distribution
    nodalK = poissrnd(K);
    % Avoid a random number zero and connections bigger than the number of
    % individuals (remove possibility of double connection from one
    % individual to another in the same direction - in opposite directions
    % they are allowed)
    while nodalK > N || nodalK == 0
        % If the number was constrained, get another value
        nodalK = poissrnd(K);
    end
    % Get a random permutation of nodalK individuals of the N possible
    % individuals in the network. The matrix is sorted to have the
    % connections ordered from low to high. The result is then transposed
    % This guarantees that all inputs are unique
    inputs{node}=sort(randperm(N,nodalK))'; 
end

% RULE SET CREATION
% Preallocation of the rules cell-array
rules = cell(N,1);
% Loop over all individuals
for node=1:N
    % And assign a random rule depending on the number of conections that
    % cetain individual has by getting a random sequence of numbers of
    % dimension (2^length, 1) and returning a boolean array by comparing
    % the results with a given probabilty
    rules{node}=rand(2.^length(inputs{node}),1)<p; 
end


