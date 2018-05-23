function [inputs,rules]=makeRBN(N,K,p)
% makes an N-K RBN (i.e., assumes K is constant for each of N nodes)
% function [inputs,rules]=makeRBN(N,K,p); 
%
% INPUT PARAMETERS
% N: number of nodes
% K: in-degree of each node
% p: probability of 1's in the boolean output function
%
% OUTPUT PARAMETERS:
% inputs: K rows by N columns 
%           (each column holds indeces of which nodes point to that node)
% rules: 2^K rows by N columns
%           (each column holds the boolean outputs for each of the 2^K
%           possible inputs, in increasing binary order)

% AUTHOR: Maggie Eppstein

clear evolveRBN %force this function to clear and re-initialize its persistent variables

if nargin < 3
    p=0.5;
end

% make the random topology (fixed in-degree of K, Poisson distributed out-degree)
inputs=zeros(K,N); % pre-allocate for efficiency
for node=1:N
    inputs(:,node)=randperm(N,K)'; %guarantees all inputs are unique
end
% inputs=randi([1 N],K,N); % this vectorizes the above loop, but doesn't
% guarantee no duplicate inputs, so it shouldn't be used

rules=rand(2.^K,N)<p; %make the random boolean output functions



