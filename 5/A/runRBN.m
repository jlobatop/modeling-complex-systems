function [meanData]=runRBN(N, K, p, time, rep)
%RUNRBN Run a Random Boolean Network certain number of times
%
% INPUTS:
% N        = size of the Random Boolean Network
% K        = average in-degree of the network
% p        = probability of 1's activation in the output
% time     = maximum simulation time
% rep      = number of times that the NK-RBN simulation will be done
%
% OUTPUTS:
% meanData = mean value for each Hamming distance
%
% Javier Lobato & Alberto Vidal, created on 2018/04/22

% In order to compute the Hamming distance in t+1 for each Hamming distance
% in t, an average between different runs must be done. Different timesteps
% may have the same Hamming distances in t but different Hamming distances
% in t+1. To do the average of all Hamming distances in t+1 for all the
% timesteps and all the runs, the next code creates two vectors (HD and nHD)
% with N+1 elements. Given that the size N determines the maximum increment
% of Hamming distances, each increment will have an element preallocated in
% the vector. In other words, if N=10, the possible normalized Hamming
% distances will be [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0], having 
% for each one an element in HD and another respective element in nHD. The
% code works the following way:
%   - Run a simulation of the NK-RBN, saving the state matrix
%   - For each element of the of the state matrix, compute the Hamming
%     distance (HD for time t)
%   - Refer to the element corresponding to HD_t in the matrix HD and nHD
%   - Store in that element of HD the value of the Hamming distance for t+1
%   - Also add 1 to the corresponding element in nHD 
%   Loop over the previous items for each repetition, computing the mean of
%   all values in HD

    % Preallocation of matrix
    HD = zeros([N+1,1]);
    nHD = zeros([N+1,1]);

    % Let's loop over the number of repetitions
    for j=1:rep
        % Run the NK-RBN simulation
        [~, ~, sm] = newRBNrun(N,K,time,p);
        % Loop over each element of the state-matrix
        for i=1:time-2
            % Compute the Hamming distance
            hdt = (sum(abs(sm(i+1,:)-sm(i,:))))/(N);
            % Get the correspondant index for the Hamming distance in t
            index = round(hdt*N+1);
            % Add to HD(index) the Hamming distance in t+1 
            HD(index) = HD(index) + (sum(abs(sm(i+2,:)-sm(i+1,:))))/(N);
            % Add to nHD(index) 1 to count the occurences of HD_t
            nHD(index) = nHD(index) + 1;
        end
    end

    % Once the loop is over, compute and return the mean
    meanData = HD ./ nHD;

end