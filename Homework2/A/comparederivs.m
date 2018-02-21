function comparederivs(allx, f, truedf1st, truedf2nd, truedf3rd)
% COMPAREDERIVS: % Compares true, 1st-order, and 2nd-order slope approximations
%
% INPUTS:
%   allx: scalar or vector of values to look at
%   f: function handle of the function to differentiate
%   truedf1st: function handle of the analytic 1st derivative function of f
%   truedf2nd: function handle of the analytic 2nd derivative function of f
%   truedf3rd: function handle of the analytic 3rd derivative function of f
%
% OUTPUTS:
%   This program produces one plot for each value in the vector allx
%   The plots show the error in the approximations as a function of step
%   size, including the optimal stepsize and its associated error
%
% sample call: comparederivs([0 5],@exp, @exp, @exp, @exp)

% Maggie Eppstein, 02/10/08; documentation improved 02/15/11
% Xing Jin and Javier Lobato, modified 02/14/18

% THIS IS A GOOD EXAMPLE OF A WELL-DOCUMENTED FILE;  NOTE THE FOLLOWING:
%   a) contents and consistent organization of function headers; first
%   comment line for LOOKFOR command, 1st contiguous comment block for HELP
%   command; always define inputs/outputs, including size constraints or
%   other pre-/post-conditions;
%   b) in-line comments should always be at one level of abstraction higher
%   than the code itself;
%   c) use of full-line UPPER-CASE in-line comments to give a high-level
%   description of what each logically-related code block does; you can 
%   read through these alone to get a good understanding of what the code 
%   does, without even looking at the code;
%   d) additional lower-case comments at the ends of potentially confusing
%   lines for clarification;


% FOR EACH X-VALUE, PLOT THE APPROXIMATION ERRORS AS A FUNCTION OF STEPSIZE
h = logspace(-20,-1,20); %logarithmically-spaced step sizes

for xi = 1:length(allx) %each x-value will get its own plot
    x = allx(xi); %get the i-th value of tthe allx vector
    
    % COMPUTE TRUE DERIVATIVE AND ITS APPROXIMATIONS
    df = truedf1st(x); % compute true derivative at x
    bdf = backdiff(x, f, h); %approximate with 1st order backwards difference
    cdf = centraldiff(x, f, h); %approximate with 2nd order central difference
    
    % COMPUTE APPROXIMATION ERRORS BY COMPARING TO TRUE DERIVATIVES
    berr = abs(df - bdf);
    cerr = abs(df - cdf);
    
    % In order to compute the optimal error, an iterative process is
    % required. An initial guess on the stepsize is made. With that initial
    % guess, a value of h_opt is computed, and evaluated again in M2 - in
    % order to get the optimal step size
    opt_stepsize = ones([2,1]);
    opt_stepsize(2) = 1e-6;
    while abs(opt_stepsize(2) - opt_stepsize(1)) > eps
        opt_stepsize(1) = opt_stepsize(2);
        M2 = max(abs(truedf2nd((x-opt_stepsize(1)):x)));
        back_hopt = 2*sqrt(eps/M2);
        opt_stepsize(2) = back_hopt;
    end
    % The error of the backwards difference is 2*sqrt(eps*M2) but it does 
    % not give the same result as evaluating the function with h_opt, so
    % the second method is used 
    back_optError = abs(df - backdiff(x, f, back_hopt));
    
    %Following the same procedure for the central differences...
    opt_stepsize = ones([2,1]);
    opt_stepsize(2) = 1e-6;
    while abs(opt_stepsize(2) - opt_stepsize(1)) > eps
        opt_stepsize(1) = opt_stepsize(2);
        M3 = max(abs(truedf3rd((x-opt_stepsize(1)):(x+opt_stepsize(1)))));
        central_hopt = (3*eps/M3)^(1/3);
        opt_stepsize(2) = central_hopt;
    end
    % The error for central differences from the mathematical derivation 
    % does not give the same value as if the function is evaluated with 
    % h_opt - the second method is again choosen
    central_optError = abs(df - centraldiff(x, f, central_hopt));

    % PLOT THE APPROXIMATION ERRORS AS A FUNCTION OF STEPSIZE
    figure

    % Plotting the optimal step sizes and its associated errors
    loglog(back_hopt, back_optError, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
    hold on
    loglog(central_hopt, central_optError, 'bs', 'MarkerSize', 9, 'MarkerFaceColor', 'b');
    
    % LINEAR REGRESSION OF LOG-LOG RELATIONSHIPS 
    % (ONLY IN REGION GOVERNED BY TRUNCATION ERROR)
    coef1 = polyfit(log(h(end-4:end)), log(berr(end-4:end)), 1);
    coef2 = polyfit(log(h(end-4:end)), log(cerr(end-4:end)), 1);

    % Plotting of the different empirical errors for all stepsizes in h
    loglog(h, berr, 'ro', 'MarkerSize', 7);
    loglog(h, cerr, 'bx', 'MarkerSize', 8);
    
    % Plotting the linear regression lines
    loglog(h(end-4:end), exp(coef1(2))*h(end-4:end).^coef1(1), 'r-');
    loglog(h(end-4:end), exp(coef2(2))*h(end-4:end).^coef2(1), 'b--');
    
    % Labeling of the plots
    set(gca, 'fontsize', 14) % be kind to the instructor's aging eyes!
    xlabel('Step size (h)') 
    ylabel('Associated error')
     legend('Backwards h_{opt}', 'Central h_{opt}','Backwards differences','Central differences',...
         ['Slope = ',num2str(coef1(1),4)],['Slope = ',num2str(coef2(1),4)],...
         'Location','BestOutside');
     title(['Evaluated at x = ',num2str(x)])
    
    %ALLOW USER TO VIEW EACH PLOT BEFORE MOVING ON TO THE NEXT
    if xi < length(allx)
        disp('Hit any key to continue...')
        pause 
    end
    
end

figure(gcf)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOTE: the following functions are placed here for convenience for this 
% demo code, but cannot be called from outside this file; in general, 
% these should be in their own files (e.g. in a directory for your personal 
% library "toolbox" that you add to the Matlab path to access your own 
% handy utility functions)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function df1 = backdiff(x, f, h) 
% BACKDIFF: 1st order backwards difference approximation to first derivative
%
% INPUTS:
% x: location(s) of where in domain to approximate the derivative
% f: handle of function to approximate derivative of
% h: stepsize(s) to use in approximation
%
% SIZE CONSTRAINTS: at least one of x or h must be a scalar, but the other
% can be of any other dimension (scalar, vector, matrix)
%
% OUTPUTS:
% df1: 1st order approximation to first deriv (slope) of f at x 
%     (same size as largest of x or h)
% 
% SAMPLE CALLS:
%   df1 = backdiff(0, @sin, [1e-3 1e-2 1e-1]) % vector of stepsizes
%   df1 = backdiff(0:.5:3, @sin, 1e-3) % vector of domain values
%
% AUTHOR: Maggie Eppstein, 2/15/2011

df1 = (f(x)-f(x-h))./h;


function df2=centraldiff(x,f,h)
% CENTRALDIFF: 2nd order central difference approximation to first derivative
%
% INPUTS:
% x: location(s) of where in domain to approximate the derivative
% f: handle of function to approximate derivative of
% h: stepsize(s) to use in approximation
%
% SIZE CONSTRAINTS: at least one of x or h must be a scalar, but the other
% can be of any dimension (scalar, vector, matrix)
%
% OUTPUTS:
% df2: 2nd order approximation to first deriv (slope) of f at x 
%     (same size as largest of x or h)
%
% SAMPLE CALLS:
%   df2 = backdiff(0, @sin, [1e-3 1e-2 1e-1]) % vector of stepsizes
%   df2 = backdiff(0:.5:3, @sin, 1e-3) % vector of domain values
%
% AUTHOR: Maggie Eppstein, 2/15/2011

df2 = (f(x+h)-f(x-h))./(2*h);

