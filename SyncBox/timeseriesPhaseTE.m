function [parameters, data] = timeseriesPhaseTE(X, Y, delay, binsize)

%%%%%
% This function computes the Phase transfer entropy (TE) and Phase 
% differential TE between time series X and Y,
% with the flow of information directed from X to Y. 
% Uses phase-space binning method combined with trial collapsing
% (Gómez-Herrero et al., 2010, Wilmer et al., 2012).
% Bin width was defined according to Scott's choice (Scott, 1992).
% 
% Input:
% X: first time series in 1-D vector
% Y: second time series in 1-D vector
% delay: prediction delay in samples; leave empty if you want the delay to 
% be based on the frequency content of the data
% binsize: binsize for the histograms of phase occurances; provide a number,
% or 'scott' or 'otnes' to use the approach by Scott or by Otnes and 
% Enochson
% 
% Outputs:
% parameter.PTE_estimate: Phase transfer entropy (bits)
% parameter.dPTE_estimate: Phase differential transfer entropy (
% normalized between 0 to 1)
% data.signal1: X
% data.signal2: Y
%
% NOTE: Our work builds upon the code included in the following works and
% implementations, so please do consider citing them:
% 
% References:
% Phase Transfer Entropy as described in:
% M Lobier, F Siebenhuhner, S Palva, JM Palva (2014) Phase transfer entropy
% : a novel phase-based measure for directed connectivity in networks 
% coupled by oscillatory interactions. Neuroimage 85, 853-872
% with implemementation inspired by Java code by C.J. Stam 
% (https://home.kpn.nl/stam7883/brainwave.html)
%
% Original authors: Matteo Fraschini, Arjan Hillebrand
%%%%%

%% check input arguments
if nargin < 2
    error('Please provide input data in format X and Y timeseries');
end

if nargin < 3
    delay = [];
elseif isdeployed
    delay = num2str(delay);% convert string to number for compiled files
end

if nargin < 4
    binsize = 'scott'; % default
end
if isdeployed & ~strmatch(binsize, 'scott') & ~strmatch(binsize, 'otnes')
    binsize = str2num(binsize); % convert string to number for compiled files
end

if (length(X) ~= length(Y))
    error('Input timeseries not of same length');
end

%% Initialisation

X = reshape(X, [1, length(X)]);
Y = reshape(Y, [1, length(Y)]);

dataXY = [X' Y'];
L = size(dataXY,1); %number of samples
N = 2; %number of signals
PTE = zeros(N,N);
dPTE = zeros(N,N);



%% Compute time series of the phases
complex_data = hilbert(dataXY);
phase_data = angle(complex_data);
phase_data = phase_data+pi;



%% Compute delay (if required)
if isempty(delay)
    % delay is based on the number of times the phase flips across time and channels, as in Brainwave (C.J. Stam)
    counter1 = 0; counter2 = 0;
    for j=1:N
        for i=2:L-1
            counter1 = counter1 + 1;
            if (phase_data(i-1,j)-pi)*(phase_data(i+1,j)-pi)<0, % make sure phase is in range [-pi pi]
                counter2 = counter2 + 1;
            end; %if
        end; %for
    end; %for
    delay = round(counter1/counter2);
end; %if



%% Compute binsize (if required)
if strmatch(binsize, 'scott')
    % binsize based on Scott D.W. (1992) Multivariate density estimation: theory, practice, and visualization. Wiley.
    binsize = 3.49*mean(std(phase_data))*L^(-1/3); % binsize as in Scott et al.
end
if strmatch(binsize, 'otnes')
    % binsize based on Otnes R. and Enochson (1972) Digital Time Series Analysis. Wiley.
    % as in Brainwave (C.J. Stam)
    Nbins = exp(0.626 + 0.4*log(L-delay-1));
    binsize = 2*pi/Nbins;
end
% get the bins
bins_w = [0:binsize:2*pi]; % BINS; NOTE: the last bin has a different size when using 'scott'. Does this matter?
Nbins = length(bins_w);


%% Compute PTE
for i=1:N
    for j=1:N
        if i~=j
            %initialise
            Py = zeros(Nbins,1); 
            Pypr_y = zeros(Nbins,Nbins); %y and x are past states.
            Py_x = zeros(Nbins,Nbins);
            Pypr_y_x = zeros(Nbins,Nbins,Nbins);
            
            % fill the bins of the phase histograms
            rn_ypr = ceil((phase_data(1+delay:end,j)/binsize));
            rn_y = ceil((phase_data(1:end-delay,j)/binsize));
            rn_x = ceil((phase_data(1:end-delay,i)/binsize));
            for kk = 1:(L-delay)
                Py(rn_y(kk)) = Py(rn_y(kk))+1;
                Pypr_y(rn_ypr(kk),rn_y(kk)) = Pypr_y(rn_ypr(kk),rn_y(kk))+1;
                Py_x(rn_y(kk),rn_x(kk)) = Py_x(rn_y(kk),rn_x(kk))+1;
                Pypr_y_x(rn_ypr(kk),rn_y(kk),rn_x(kk)) = Pypr_y_x(rn_ypr(kk),rn_y(kk),rn_x(kk))+1;
            end
            
            % compute probabilities and conditional probabilities
            Py = Py/(L-delay);
            Pypr_y = Pypr_y/(L-delay);
            Py_x = Py_x/(L-delay);
            Pypr_y_x = Pypr_y_x/(L-delay);
            
            Hy = -nansum(Py.*log2(Py));
            Hypr_y = -nansum(nansum(Pypr_y.*log2(Pypr_y)));
            Hy_x = -nansum(nansum(Py_x.*log2(Py_x)));
            Hypr_y_x = -nansum(nansum(nansum(Pypr_y_x.*log2(Pypr_y_x))));
            
            % Compute PTE
            PTE(i,j) = Hypr_y+Hy_x-Hy-Hypr_y_x;
        end
    end
end


%% Compute dPTE
tmp = triu(PTE) + tril(PTE)';
dPTE = [triu(PTE./tmp,1) + tril(PTE./tmp',-1)];

%%
parameters.PTE_estimate = PTE(1,2);
parameters.dPTE_estimate = dPTE(1,2);
data.signal1 = X';
data.signal2 = Y';
end
