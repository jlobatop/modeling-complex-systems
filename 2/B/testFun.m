function [ dydt ] = testFun(t, y, a)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
dydt = zeros([2,1]);
dydt(1) = y(2);
dydt(2) = 0.5*y(1)+a*y(2);
end

