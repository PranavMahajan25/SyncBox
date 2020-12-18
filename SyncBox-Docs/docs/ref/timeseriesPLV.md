## Phase Locking Value

`function [parameters, data] = timeseriesPLV(X,Y)`

Phase-locking value is measure of the phase-locking between two timeseries i.e. the generalized phase relation or the phase difference stays nearly constant throughout.
This function computes the Phase locking value between time series X & Y,
uses Hilbert transform for phase extraction. 
 After extracting phases from both timeseries, instantaneous phase relation is computed in order to estimate PLV. 
 
 For more details, please see Lachaux et al., 1999, 
"Measuring phase synchrony in brain signals"


#### Inputs:
`X`: first time series in 1-D vector

`Y`: second time series in 1-D vector

#### Outputs:
`parameter.PLV_estimate`: PLV estimate (between 0 to 1)

`data.signal1`: X

`data.signal2`: Y



## Example usage
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

NOTE: Our work builds upon the code included in the following works and
implementations, so please do consider citing them:

#### References:
[1] Lowet, E., Roberts, M. J., Bonizzi, P., Karel, J., & De Weerd, P. (2016). Quantifying neural oscillatory synchronization: a comparison between spectral coherence and phase-locking value approaches. PloS one, 11(1)

[2] Lachaux, J. P., Rodriguez, E., Martinerie, J., & Varela, F. J. (1999). Measuring phase synchrony in brain signals. Human brain mapping, 8(4), 194-208.