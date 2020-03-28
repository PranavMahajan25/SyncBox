## Spectral Coherence

`function [parameters, data]=timeseriesCoherence(X,Y,n)`

This function computes the Spectral Coherence between 'n' trials of 
2 time series X & Y. In spectral coherence computation, the time-domain signals of each trial are transformed in the frequency domain
and phase-coupling is assessed frequency-by-frequency.


#### Inputs:
`X`: n trials of first time series in 2-D vector [n x m]

`Y`: n trials of second time series in 2-D vector [n x m] 

where n is the number of trials and m is the number of datapoints in a single timeseries.

#### Outputs:
`parameter.Coh_estimate`: Coherence estimate (between 0 to 1)

`data.trial`: X and Y trials in cell format 


## Example usage
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

NOTE: Our work builds upon the code included in the following works and
implementations, so please do consider citing them:

#### References:
[1] Lowet, E., Roberts, M. J., Bonizzi, P., Karel, J., & De Weerd, P. (2016). Quantifying neural oscillatory synchronization: a comparison between spectral coherence and phase-locking value approaches. PloS one, 11(1)