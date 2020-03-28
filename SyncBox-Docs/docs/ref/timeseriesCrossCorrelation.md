## Cross Correlation

`function [parameters, data] = timeseriesCrossCorrelation(X,Y, lag, maxlag, scaleopt)`

This function computes the cross correlation between time series X and Y
and returns the value for a given value of lag (by default 0 lag), can
also give normalized/biased/unbiased value. Utilizes default [xcorr](https://in.mathworks.com/help/matlab/ref/xcorr.html)
function from MATLAB. 

#### Inputs:
`X`: first time series in 1-D vector

`Y`: second time series in 1-D vector

`lag`: lag value

`maxlag`: limits the lag range from -maxlag to maxlag

`scaleopt`: can changed to 'none', 'biased', 'unbiased' but by default 'normalized'

#### Outputs:
`parameters.Corr`: Cross correlation value at the given lag value

`data.signal1`: X

`data.signal2`: Y


## Example usage
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
