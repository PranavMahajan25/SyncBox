function [parameters, data] = timeseriesNSE(X, Y, m, n)
%%%%%
% This function computes the Normalized Shannon Entropy sync measure between time series 
% X & Y,
% Uses Hilbert transform for Phase extraction.
% After extracting phases from both timeseries, 
% the Shannon entropy of the phase relation histogram is calculated
% This value is normalized by the maximum possible Shannon Entropy
%
% Inputs:
% X: first time series in 1-D vector
% Y: second time series in 1-D vector
% m: multiple for the first signal, default is 1
% n: multiple for the second signal, default is 1
%
% Outputs:
% parameter.NSE_estimate: normalised Shannon Entropy estimate 
% (between 0 to 1)
% data.signal1: X
% data.signal2: Y
%
% Author: Advait Rane, Pranav Mahajan
%
% NOTE: Our work builds upon the code included in the following works and
% implementations, so please do consider citing them:
% 
% References:
% [1] Rosenblum,M.,Pikovsky,A.,Kurths,J.,Schafer,C.,Tass,P.:Chapter 9 phase 
% synchronization: From theory to data analysis. In: Neuro-Informatics and 
% Neural Mod- elling, pp. 279–321. Elsevier (2001).
% [2] Notbohm, A., Kurths, J., Herrmann, C.S.: Modification of brain 
% oscillations via rhythmic light stimulation provides evidence for entrainment 
% but not for superposition of event-related responses. Frontiers in Human 
% Neuroscience 10, 10 (2016).
%

%%%%%

%% check input arguments
if nargin < 2
    error('Please provide input data in format X and Y timeseries');
end

if nargin < 4
    m = 1;
    n = 1;
end

%% Code

X = reshape(X, [1, length(X)]);
Y = reshape(Y, [1, length(Y)]);

signal1 = X; %
signal2 = Y; %

p1=angle(hilbert((signal1)));
p2=angle(hilbert((signal2)));
pr=angle(exp(1i*m*p1)./exp(1i*n*p2));
wrap_pr = wrapToPi(pr);

% Number of bins set to 80 as per implementation in Notbohm et al. [2]
hist_nbins = 80;
S_max = log(hist_nbins);

hist_delta = histogram(wrap_pr, hist_nbins, 'Normalization', 'probability').Values;
S = -1*dot(hist_delta(hist_delta>0), log(hist_delta(hist_delta>0)));
S_norm = (S_max - S)/S_max;

parameters.NSE_estimate=S_norm;
data.signal1 = signal1;
data.signal2 = signal2;
end