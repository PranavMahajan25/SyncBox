# Neuron mass model timeseries tutorial
In Tutorial one we computed synchronization measures on output of two coupled oscillators. 
Now in this tutorial we will apply these measures to a pre-computed output of two coupled brain-inspired  neural networks.
We demonstrate how to filter output timeseries from a simulation of Neuron mass model of two coupled Lateral Geniculate Nuclei (LGNs) 
and utilize the toolbox functions to estimate synchronozation measure estimates.

 
#### Construct appropriate filter.
Appropriate filter construction is necessary for PLV calculation as we use Hilbert transform for phase extraction. 
Another variant using Morlet wavelet (which we have not implemented) filters in it's own band so in that case filtering won't be necessary.

``` matlab
% THE TIME PARAMETERS AND VECTOR
delt=0.001; %% 1 millisecond
endtime=40; %% seconds

timevec=0:delt:endtime;
timelen=numel(timevec);

% Construct an FDESIGN object and call its BUTTER method.
Fs = 1000;
Fc1 = 1; % First Cutoff Frequency
Fc2 = 200; % Second Cutoff Frequency
N = 10; % Order
h = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');
[B,A]=sos2tf(Hd.sosMatrix,Hd.Scalevalues);
```

#### Load, filter and plot timeseries 
``` matlab
load('data.mat')

Vtcr1 = filtfilt(B,A,squeeze(data(1, :)));
% hold on; 
% plot(timevec(15001:20000), Vtcr1(15001:20000))
Vtcr2 = filtfilt(B,A,squeeze(data(2, :)));
% hold on; 
% plot(timevec(15001:20000), Vtcr2(15001:20000))

```

#### Cross Correlation
```matlab
>> X1 = Vtcr1(15001:20000);
>> Y1 = Vtcr2(15001:20000);
>> [parameters,data] = timeseriesCrossCorrelation(X1, Y1, 0, 10, 'normalized');
>> Corr = parameters.Corr;
>> signal1 = data.signal1;
>> signal2 = data.signal2;
>> Corr
Corr =

	0.9814
```
#### Phase locking value (PLV) estimation
```matlab
>> X1 = Vtcr1(15001:20000);
>> Y1 = Vtcr2(15001:20000);
>> [parameters, data]=timeseriesPLV(X1,Y1);
>> PLV = parameters.PLV_estimate;
>> signal1 = data.signal1;
>> signal2 = data.signal2;
>> PLV
PLV =

	0.9881
```
#### Spectral Coherence estimate
```matlab
>> X1 = Vtcr1(15001:20000);
>> Y1 = Vtcr2(15001:20000);
>> X2 = Vtcr1(20001:25000);
>> Y2 = Vtcr2(20001:25000);
>> X3 = Vtcr1(25001:30000);
>> Y3 = Vtcr2(25001:30000);
>> X = [X1; X2; X3]; % 3 trials
>> Y = [Y1; Y2; Y3]; % 3 trials
>> [parameters,data] = timeseriesCoherence(X, Y);
>> Coh = parameters.Coh_estimate;
>> trial_data = data.trial;
>> Coh
Coh =

	1
```
#### Mutual Info estimated using Gaussian kernels
```matlab
>> X1 = Vtcr1(15001:20000);
>> Y1 = Vtcr2(15001:20000);
>> [parameters,data] = timeseriesMI_kernel(X1, Y1);
>> MI = parameters.MI_estimate;
>> h = parameters.kernel_width;
>> signal1 = data.signal1;
>> signal2 = data.signal2;
>> MI
MI =

    1.2277
```
#### Transfer Entropy (TE) estimation  (Rank method - simple binning)
```matlab
>> X1 = Vtcr1(15001:20000);
>> Y1 = Vtcr2(15001:20000);
>> t=2; w=2; % time lag 
>> l=1; k=1; % block lengths
>> [parameters, data] = timeseriesTE_rank(X1,Y1,l,k,t,w,128);
>> TE = parameters.TE_estimate;
>> signal1 = data.signal1;
>> signal2 = data.signal2;
>> TE
TE =

    2.6225

```
#### Phase TE and differential Phase TE estimation 
```matlab
>> X1 = Vtcr1(15001:20000);
>> Y1 = Vtcr2(15001:20000);
>> [parameters, data] = timeseriesPhaseTE(X1, Y1);
>> PTE = parameters.PTE_estimate;
>> dPTE = parameters.dPTE_estimate;
>> signal1 = data.signal1;
>> signal2 = data.signal2;
>> PTE, dPTE
PTE =

    0.1695


dPTE =

    0.5194

```
####  Directed Nonlinear Interdependence
Note: Takes significant time to compute, ranking based solution can improve compute time.
```matlab
>> X1 = Vtcr1(15001:20000);
>> Y1 = Vtcr2(15001:20000);
>> [parameters,data] = timeseriesNLI(X1, Y1, 32, 1024);
>> M = parameters.NLI_estimate;
>> signal1 = data.signal1;
>> signal2 = data.signal2;
>> M
M =

     1
```