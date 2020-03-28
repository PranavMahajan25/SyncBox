function [parameters, data] = timeseriesCrossCorrelation(X,Y, lag, maxlag, scaleopt)

%%%%%
% This function computes the cross correlation between time series X and Y
% and returns the value for a given value of lag (by default 0 lag), can
% also give normalized/biased/unbiased value. Utilizes default xcorr
% function from MATLAB. https://in.mathworks.com/help/matlab/ref/xcorr.html
% 
% Inputs:
% X: first time series in 1-D vector
% Y: second time series in 1-D vector
% lag: lag value
% maxlag: limits the lag range from -maxlag to maxlag
% scaleopt: can changed to 'none', 'biased', 'unbiased'
% but by default 'normalized'
%
% Outputs:
% parameters.Corr: Cross correlation value at the given lag value
% data.signal1: X
% data.signal2: Y
%
% Author: Pranav Mahajan
%
%%%%%

%% check input arguments
% This assumes you'll provide arguments in the same order, changing or
% skipping arguments will lead to errors.

if nargin < 2
    error('Please provide input data in format X and Y timeseries');
end
if nargin == 2
    lag = 0;
    [c,lags] = xcorr(X,Y,'normalized');
end
if nargin == 3
    [c,lags] = xcorr(X,Y,'normalized');
end
if nargin == 4
    [c,lags] = xcorr(X,Y,maxlag,'normalized');
end
if nargin == 5
    [c,lags] = xcorr(X,Y,maxlag,scaleopt);
end

zeropoint = 0.5 * (length(lags)+1);

parameters.Corr = c(zeropoint+lag);
data.signal1 = X;
data.signal2 = Y;
end
