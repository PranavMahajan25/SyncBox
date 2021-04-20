## Conditional Probability Index

`function [parameters, data] = timeseriesCPI(X, Y, m, n)`

This function computes the Conditional Probability Index value between time series X & Y, for m:n synchronization. We use Hilbert transform for Phase extraction. After extracting phases from both timeseries, the method detailed in Rosenblum et. al. is followed to calculate the Conditional Probability Index using a stroboscopic approach.


#### Inputs:

`X`: first time series in 1-D vector

`Y`: second time series in 1-D vector

`m`(optional): multiple for the first time series, default is 1

`n`(optional): multiple for the second time series, default is 1

#### Outputs:

`parameter.CPI_estimate` : Conditional Probability Index estimate (between 0 to 1)

`data.signal1` : X

`data.signal2` : Y



## Example usage
```matlab
>> X1 = Vtcr1(15001:20000);
>> Y1 = Vtcr2(15001:20000);
>> m = 1;
>> n = 1;
>> [parameters, data]=timeseriesCPI(X1,Y1,m,n);
>> CPI = parameters.CPI_estimate;
>> signal1 = data.signal1;
>> signal2 = data.signal2;
```

NOTE: Our work builds upon the code included in the following works and
implementations, so please do consider citing them:

#### References:
[1] Rosenblum,M.,Pikovsky,A.,Kurths,J.,Schafer,C.,Tass,P.:Chapter 9 phase synchronization: From theory to data analysis. In: Neuro-Informatics and Neural Mod- elling, pp. 279–321. Elsevier (2001).
