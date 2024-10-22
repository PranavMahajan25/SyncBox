% Note: Nonlinear Interdependence takes much longer to compute, so consider 
% commenting it out if not required.

addpath('../toolbox')

clear all;
clc;

% Construct an FDESIGN object and call its BUTTER method.
Fs = 1000;
Fc1 = 1; % First Cutoff Frequency
Fc2 = 200; % Second Cutoff Frequency
N = 10; % Order
h = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');
[B,A]=sos2tf(Hd.sosMatrix,Hd.Scalevalues);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prequisite: 
% Load the data from some .mat file or generate your own data.
% Here we use a pre-computed data from two coupled LGN system where Vtcr1
% and Vtcr2 are the output timeseries. In order to use these functions for
% your system, just change the X1 and Y1 input timeseries and you are good 
% to go!

load('data.mat')

Vtcr1 = filtfilt(B,A,squeeze(data(1, :)));
Vtcr2 = filtfilt(B,A,squeeze(data(2, :)));


%% Phase locking value (PLV) estimation

X1 = Vtcr1(15001:20000);    
Y1 = Vtcr2(15001:20000);

[parameters, data]=timeseriesPLV(X1,Y1);
PLV = parameters.PLV_estimate;
signal1 = data.signal1;
signal2 = data.signal2;

PLV
%% Transfer Entropy (TE) estimation  (Rank method - simple binning)

X1 = Vtcr1(15001:20000);
Y1 = Vtcr2(15001:20000);
t=2; w=2; % time lag 
l=1; k=1; % block lengths
[parameters, data] = timeseriesTE_rank(X1,Y1,l,k,t,w,128);

TE = parameters.TE_estimate;
signal1 = data.signal1;
signal2 = data.signal2;

TE
%% Phase TE and differential Phase TE estimation 

X1 = Vtcr1(15001:20000);
Y1 = Vtcr2(15001:20000);
[parameters, data] = timeseriesPhaseTE(X1, Y1);

PTE = parameters.PTE_estimate;
dPTE = parameters.dPTE_estimate;
signal1 = data.signal1;
signal2 = data.signal2;

PTE
%% Mutual Info estimated using Gaussian kernels

X1 = Vtcr1(15001:20000);
Y1 = Vtcr2(15001:20000);
[parameters,data] = timeseriesMI_kernel(X1, Y1);

MI = parameters.MI_estimate;
h = parameters.kernel_width;
signal1 = data.signal1;
signal2 = data.signal2;

MI
%% Spectral Coherence estimate

X1 = Vtcr1(15001:20000);
Y1 = Vtcr2(15001:20000);

X2 = Vtcr1(20001:25000);
Y2 = Vtcr2(20001:25000);

X3 = Vtcr1(25001:30000);
Y3 = Vtcr2(25001:30000);

X = [X1; X2; X3];
Y = [Y1; Y2; Y3];

[parameters,data] = timeseriesCoherence(X, Y);

Coh = parameters.Coh_estimate;
trial_data = data.trial;

Coh
%% Cross correlation 

X1 = Vtcr1(15001:20000);
Y1 = Vtcr2(15001:20000);

% [parameters,data] = timeseriesCrossCorrelation(X1, Y1,0,10,'normalized');
[parameters,data] = timeseriesCrossCorrelation(X1, Y1);


Corr = parameters.Corr;
signal1 = data.signal1;
signal2 = data.signal2;

Corr
%% Normalised Shannon Entropy

X1 = Vtcr1(15001:20000);
Y1 = Vtcr2(15001:20000);

[parameters,data] = timeseriesNSE(X1, Y1);


NSE = parameters.NSE_estimate;
signal1 = data.signal1;
signal2 = data.signal2;

NSE
close all;

%% Conditional Probability Index

X1 = Vtcr1(15001:20000);
Y1 = Vtcr2(15001:20000);

[parameters,data] = timeseriesCPI(X1, Y1);


CPI = parameters.CPI_estimate;
signal1 = data.signal1;
signal2 = data.signal2;

CPI
close all;

% %% Directed Nonlinear Interdependence
% % Takes significant time to compute - ranking based solution can improve
% 
% X1 = Vtcr1(15001:20000);
% Y1 = Vtcr2(15001:20000);
% 
% [parameters,data] = timeseriesNLI(X1, Y1, 32, 1024);
% 
% M = parameters.NLI_estimate;
% signal1 = data.signal1;
% signal2 = data.signal2;

% M

