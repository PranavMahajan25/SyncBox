function [parameters, data] = timeseriesPLV(X,Y)
%%%%%
% This function computes the Phase locking value between time series X & Y,
% Uses Hilbert transform for Phase extraction.
% After extracting phases from both timeseries, 
% instantaneous phase relation is computed in order to estimate PLV. 
% For details, please see Lachaux et al., 1999, 
% "Measuring phase synchrony in brain signals"
%
% Inputs:
% X: first time series in 1-D vector
% Y: second time series in 1-D vector
%
% Outputs:
% parameter.PLV_estimate: PLV estimate (between 0 to 1)
% data.signal1: X
% data.signal2: Y
%
% Author: Pranav Mahajan
%
% NOTE: Our work builds upon the code included in the following works and
% implementations, so please do consider citing them:
% 
% References:
%%%%%

%% check input arguments
if nargin < 2
    error('Please provide input data in format X and Y timeseries');
end

%% Code

X = reshape(X, [1, length(X)]);
Y = reshape(Y, [1, length(Y)]);

signal1 = X; %
signal2 = Y; %

p1=angle(hilbert((signal1)));
p2=angle(hilbert((signal2)));
px=(exp(1i*angle(exp(1i*p1)./exp(1i*p2)))); % instant. phase-relation
h_est = abs(mean(px));

parameters.PLV_estimate=h_est;
data.signal1 = signal1;
data.signal2 = signal2;
end