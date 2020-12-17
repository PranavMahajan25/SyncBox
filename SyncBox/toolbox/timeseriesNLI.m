function [parameters, data] = timeseriesNLI(X,Y,k,m)
%%%%%
% This function calculates directed Nonlinear Interdependence M(X|Y) from 
% two timeseries X and Y. Nonlinear Interdependence relies on state space 
% reconstruction and Taken's theorem. It doesn't assume any strict 
% functional relationship between dyniamics of the underlying system.
% Exhanging X and Y will give M(Y|X), as it is a directional measure.
% 
% For more details refer to Andrzejak et. al. (2003).
% 
% Inputs:
% X: first time series in 1-D vector
% Y: second time series in 1-D vector
% k: Number of nearest neighbours considered while calculating mean squared
% Euclidean distance Rk
% m: Embedding dimension
% 
% Outputs:
% parameter.NLI_estimate: NLI estimate (between 0 to 1)
% data.signal1: X
% data.signal2: Y
%
% Author: Pranav Mahajan
%
% References:
% Andrzejak, R. G., Kraskov, A., Stögbauer, H., Mormann, F., & Kreuz, 
% T. (2003). Bivariate surrogate techniques: necessity, strengths, and 
% caveats. Physical review E, 68(6), 066202.
%%%%%
%% check input arguments
if nargin < 2
    error('Please provide input data in format X and Y timeseries');
end
if nargin < 3
    error('Please provide k - number of nearest neighbours');
end
if nargin < 4
    error('Please provide m - embedding dimension');
end

%% Initialisation

X = reshape(X, [1, length(X)]);
Y = reshape(Y, [1, length(Y)]);

Xn =  X(1:1+m-1);
for i = 2:(length(X) - m +1)
    Xn = vertcat(Xn, X(i:i+m-1));
end

Yn =  Y(1:1+m-1);
for i = 2:(length(Y) - m +1)
    Yn = vertcat(Yn, Y(i:i+m-1));
end

RkX = zeros(1, length(Xn));
for n = 1:length(Xn)
    Z = knnsearch(Xn,Xn(n,:),'K', k, 'IncludeTies', true);
    idx = Z{1};
    for j = 1:length(idx)
        RkX(n) = RkX(n) + sum((Xn(n,:) - Xn(j,:)).^2);
    end    
    RkX(n) = RkX(n) / k;
end

RkX_givenY = zeros(1, length(Xn));
for n = 1:length(Yn)
    Z = knnsearch(Yn,Yn(n,:),'K', k, 'IncludeTies', true);
    idx = Z{1};
    for j = 1:length(idx)
        RkX_givenY(n) = RkX_givenY(n) + sum((Xn(n,:) - Xn(j,:)).^2);
    end    
    RkX_givenY(n) = RkX_givenY(n) / k;
end

RnX = zeros(1, length(Xn));
for n = 1:length(Xn)
    for j = 1:length(Xn)
        RnX(n) = RnX(n) + sum((Xn(n,:) - Xn(j,:)).^2);
    end    
    RnX(n) = RnX(n) / k;
end

M = 0;

for n = 1:length(RnX)
    num = RnX(n) - RkX_givenY(n);
    denom = RnX(n) - RkX(n);
    M = M + (num/denom);
end

M = M/length(RnX);

parameters.NLI_estimate=M;
data.signal1 = Xn;
data.signal2 = Yn;
end
