function [dxdt] = lvSystem(t, x, a)
%LVSYSTEM Lotka-Volterra System implementation
% INPUTS:
%   t: although not necessary for direct evaluation, it is necesary for the
%       different integration methods to work properly
%   x: 3-element vector in which the system will be evaluated
%   a: alpha value for the A matrix (already included in the code)
%
% OUTPUTS:
%   dxdt: output result of the system 
%
% sample call:
%            dxdt = lvSystem(t, [x1 x2 x3], alpha)

% Javier Lobato, created 02/20/2018

% Preallocation of the output function in a column vector
dxdt = zeros([3,1]);

% A matrix definition with the alpha parameter from the input
A = [0.5 0.5 0.1; -0.5 -0.1 0.1; a 0.1 0.1];

% Looping over the three variable of the Lotka-Volterra system
for i = 1:3
    dxdt(i) = x(i)*(A(i,1)*(1-x(1)) + A(i,2)*(1-x(2)) + A(i,3)*(1-x(3)));
end

end

