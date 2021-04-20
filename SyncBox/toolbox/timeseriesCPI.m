function [parameters, data] = timeseriesCPI(X, Y, m, n)
%%%%%
% This function computes the Conditional Probability Index value between 
% time series X & Y.
% Uses Hilbert transform for Phase extraction.
% After extracting phases from both timeseries, 
% the method detailed in Rosenblum et. al. is followed to calculate the
% Conditional Probability Index using a stroboscopic approach.
%
% Inputs:
% X: first time series in 1-D vector
% Y: second time series in 1-D vector
% m: multiple for the first time series, default is 1
% n: multiple for the second time series, default is 1
%
% Outputs:
% parameter.CPI_estimate: Conditional Probability Index estimate (between 0 to 1)
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
%%%%%

%% check input arguments
if nargin < 2
    error(['Please provide input data in format X and Y timeseries, ' ...
        'along with m and n multiples']);
end

if nargin < 4
    n = 1;
    m = 1;
end

%% Code

X = reshape(X, [1, length(X)]);
Y = reshape(Y, [1, length(Y)]);

signal1 = X; %
signal2 = Y; %

lambda = 0;
    
% get the phases from the signals
phi1 = angle(hilbert(signal1));
phi2 = angle(hilbert(signal2));

unwrap_phi1 = unwrap(phi1);
unwrap_phi2 = unwrap(phi2);

mod_phi1 = mod(unwrap_phi1, 2*pi*m);
mod_phi2 = mod(unwrap_phi2, 2*pi*n);

M = size(mod_phi1);
M = M(2);
% Number of bins calculated using formula in Rosenblum et al.[1]
N = round(exp(0.626 +0.4*log(M-1)));

mod_phi1_hist = histogram(mod_phi1, N);

for nbin = 1:mod_phi1_hist.NumBins
    bin_low = mod_phi1_hist.BinEdges(nbin);
    bin_high = mod_phi1_hist.BinEdges(nbin+1);
    
    lambda_l = 0;
    M_l = 0;
    for i = 1:M
        if (mod_phi1(1, i) >= bin_low) && (mod_phi1(1, i) < bin_high)
            eta = mod_phi2(1, i);
            lambda_l = lambda_l + exp(1i*(eta/n));
            M_l = M_l + 1;
        end
    end
    if M_l > 0
        lambda_l = lambda_l/M_l;
    end
    
    lambda = lambda + abs(lambda_l);
end
    
    lambda = lambda/N;

parameters.CPI_estimate=lambda;
data.signal1 = signal1;
data.signal2 = signal2;
end