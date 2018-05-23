function [tspan, y] = euler_integrator(fun, tspan, y0)
%EULER Implementation of the forward Euler integration method
% INPUTS:
%   fun: function that wants to be integrated
%   tspan: interval of integration, that goes from intial time to the final
%       time [t0 t1 t2 t3 ... tf] - it includes all timesteps
%   y0: initial conditions for the function, it must have the SAME length
%       as the desired output y
%
% OUTPUTS:
%   tspan: times in which the integration has been carried out (the same as
%       the input array
%   y: values of the function after the integration
%
% sample call (for a function with extra arguments):
%            [t, y] = euler_integrator(@(t,y) function(t,y,a), tspan, y0)

% Javier Lobato, created 02/20/2018

% First of all, the function will check that the tspan vector has all
% timesteps of the same size. To do that a subtraction of the i element
% with respect the i-1 element is carried out, comparing all the values of 
% the vector with one of its elements (all must be the same)
timestep = tspan(2:length(tspan))-tspan(1:length(tspan)-1);

if all(round(timestep, 10) ~= round(timestep(1),10))
    disp('Not equally spaced tspan')
else
    h = timestep(1);
end

% ode45 returns a column vector, so to keep the structure when possible...
y = zeros([length(y0), length(tspan)]); 

% Set the initial values to the solution vector
y(:, 1) = y0;

% Loop over the whole time vector - 1 (the first initial value has been
% already included in the solution)
for i = 1:length(tspan)-1
    % Definition of the Euler integration method
    y(:, i+1) = y(:, i) + h .* fun(tspan(i), y(:, i));
end

end

