function [parameters, data] = timeseriesMI_kernel(X, Y, h, ind)
%%%%%
% Mutual information is an information-theoretic measure that can quantify 
% non-linear dependencies between systems, unlike linear cross-correlation.
% It quantifiesthe amount of information about one system obtained by 
% knowing about theother system
%
% This function computes the Kernel-based estimate for mutual information 
% I(X, Y) between time series X and Y.
% Data is first copula-transformed, then marginal and joint probability 
% distributions are estimated using Gaussian kernels.
% 
% Inputs:
% X: first time series in 1-D vector
% Y: second time series in 1-D vector
% h: kernel width
% ind: subset of data on which to estimate MI
% 
% Outputs:
% parameter.MI_estimate: Mutual information (bits)
% parameter.kernel_width: kernel width 'h'
% data.signal1: X
% data.signal2: Y
%
% NOTE: Our work builds upon the code included in the following works and
% implementations, so please do consider citing them:
%
% References:
% Mikhail (2020). Kernel estimate for (Conditional) Mutual Information 
% (https://www.mathworks.com/matlabcentral/fileexchange/30998-kernel-
% estimate-for-conditional-mutual-information), MATLAB Central File 
% Exchange. Retrieved March 20, 2020. 
%
%%%%%

[Nx, Mx]=size(X);
[Ny, My]=size(Y);
if any([Nx Ny My] ~= [1 1 Mx])
    error('Bad sizes of arguments');
end
if nargin < 3
    % Yields unbiased estiamte when Mx->inf 
    % and low MSE for two joint gaussian variables
    alpha = 0.25;
    h = (Mx + 1) / sqrt(12) / Mx ^ (1 + alpha);
end
if nargin < 4
    ind = 1:Mx;
end

% Copula-transform array - rank and scale to [0, 1]
[Xs Xi] = sort(X, 2);
[Xa Xr] = sort(Xi, 2);
x = (Xr - 1) / (size(Xr, 2) - 1);

[Ys Yi] = sort(Y, 2);
[Ya Yr] = sort(Yi, 2);
y = (Yr - 1) / (size(Yr, 2) - 1);

h2 = 2*h^2;
% Pointwise values for kernels
Kx = squareform(exp(-ssqd([x;x])/h2))+eye(Mx);
Ky = squareform(exp(-ssqd([y;y])/h2))+eye(Mx);
% Kernel sums for marginal probabilities
Cx = sum(Kx);
Cy = sum(Ky);
% Kernel product for joint probabilities
Kxy = Kx.*Ky;
f = sum(Cx.*Cy)*sum(Kxy)./(Cx*Ky)./(Cy*Kx);
I = mean(log(f(ind)));


parameters.MI_estimate = I;
parameters.kernel_width = h;
data.signal1 = X;
data.signal2 = Y;

end
