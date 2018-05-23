%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                              HOMEWORK #3.A                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Jack Houk and Javier Lobato, created 03/03/2018

% Let's clear the environment completely
clear all; clc

%% Deterministic, synchronous, specified IC (fig 6.6)
%fig 6.6 (a)
greenbergHastings(1, 1, 2, 0, 'case 1', 1, 'sync', 0, 'noSave');
%fig 6.6 (b)
greenbergHastings(1, 1, 2, 0, 'case 2', 1, 'sync', 0, 'noSave');

%% Deterministic, synchronous, IC case 1, longer runs (fig 6.7)
%fig 6.7 (a) - iteration 0
greenbergHastings(15, 1, 2, 0, 'case 1', 1, 'sync', 0, 'saveLast');
%fig 6.7 (a) - iteration 1
greenbergHastings(15, 1, 2, 1, 'case 1', 1, 'sync', 0, 'saveLast');
%fig 6.7 (a) - iteration 2
greenbergHastings(15, 1, 2, 2, 'case 1', 1, 'sync', 0, 'saveLast');
%fig 6.7 (a) - iteration 3
greenbergHastings(15, 1, 2, 3, 'case 1', 1, 'sync', 0, 'saveLast');
%fig 6.7 (a) - iteration 4
greenbergHastings(15, 1, 2, 4, 'case 1', 1, 'sync', 0, 'saveLast');
%fig 6.7 (a) - iteration 5
greenbergHastings(15, 1, 2, 5, 'case 1', 1, 'sync', 0, 'saveLast');

%% Deterministic, synchronous, IC case 1, longer runs (fig 6.7)
%fig 6.7 (b) - iteration 0
greenbergHastings(15, 1, 2, 0, 'case 2', 1, 'sync', 0, 'saveLast');
%fig 6.7 (b) - iteration 13
greenbergHastings(15, 1, 2, 13, 'case 2', 1, 'sync', 0, 'saveLast');
%fig 6.7 (b) - iteration 14
greenbergHastings(15, 1, 2, 14, 'case 2', 1, 'sync', 0, 'saveLast');
%fig 6.7 (b) - iteration 15
greenbergHastings(15, 1, 2, 15, 'case 2', 1, 'sync', 0, 'saveLast');
%fig 6.7 (b) - iteration 16
greenbergHastings(15, 1, 2, 16, 'case 2', 1, 'sync', 0, 'saveLast');
%fig 6.7 (b) - iteration 17
greenbergHastings(15, 1, 2, 17, 'case 2', 1, 'sync', 0, 'saveLast');

%% Stochastic (high infection prob), synchronous, random IC
greenbergHastings(49, 1, 2, 9, 'rand', 0.7, 'sync', 0, 'noSave');

%% Stochastic (low infection prob), synchronous, random IC
greenbergHastings(49, 1, 2, 5, 'rand', 0.1, 'sync', 0, 'noSave');

%% Deterministic, asynchronous, random IC
greenbergHastings(21, 1, 2, 9, 'rand', 1, 'async', 0, 'saveAll');

%% Deterministic, synchronous, IC case 1 to see random immigration
SIR = greenbergHastings(21,1, 2, 4, 'case 1', 1, 'sync', 0.75, 'noSave');
