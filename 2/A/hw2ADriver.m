%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                              HOMEWORK #1.A                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Xing Jin and Javier Lobato, modified 02/14/18

% By executing this driver, the function comparederivs is called for three
% different points (pi/4, pi/2 and pi) applied to the function @sin. The
% first derivative of @sin is known and it is also used as input for the  
% function as @cos. The second derivative of sin(x) is -sin(x) and the
% third derivative of sin(x) is -cos(x) (some functions have been created
% to account for the signs)

% Let's clear the workspace
clear all; close all; clc

% Calling to comparederivs with its arguments
comparederivs([pi/4 pi/2 pi], @sin, @cos, @truedf2nd, @truedf3rd);