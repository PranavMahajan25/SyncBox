## Normalized Shannon Entropy

`function [parameters, data] = timeseriesNSE(X, Y, m, n)`

This function computes the Normalized Shannon Entropy sync measure between time series X & Y, for m:n synchronization. Uses Hilbert transform for Phase extraction. After extracting phases from both timeseries, the Shannon entropy of the phase relation histogram is calculated. This value is normalised by the maximum possible Shannon entropy for the histogram.


#### Inputs:

`X`: first time series in 1-D vector

`Y`: second time series in 1-D vector

`m`: multiple for the first signal, default is 1

`n`: multiple for the second signal, default is 1


#### Outputs:

`parameter.NSE_estimate`: normalaised Shannon Entropy estimate (between 0 to 1)

`data.signal1`: X

`data.signal2`: Y




## Example usage
```matlab
>> X1 = Vtcr1(15001:20000);
>> Y1 = Vtcr2(15001:20000);
>> m = 1;
>> n = 1;
>> [parameters, data]=timeseriesNSE(X1,Y1,m,n);
>> NSE = parameters.NSE_estimate;
>> signal1 = data.signal1;
>> signal2 = data.signal2;
```

NOTE: Our work builds upon the code included in the following works and
implementations, so please do consider citing them:

#### References:
[1] Rosenblum,M.,Pikovsky,A.,Kurths,J.,Schafer,C.,Tass,P.:Chapter 9 phase synchronization: From theory to data analysis. In: Neuro-Informatics and Neural Mod- elling, pp. 279–321. Elsevier (2001).

[2] Notbohm, A., Kurths, J., Herrmann, C.S.: Modification of brain oscillations via rhythmic light stimulation provides evidence for entrainment but not for super- position of event-related responses. Frontiers in Human Neuroscience 10, 10 (2016).
