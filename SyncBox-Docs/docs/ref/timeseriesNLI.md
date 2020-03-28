## Directed Nonlinear Interdependence

`function [parameters, data] = timeseriesNLI(X,Y,k,m)`

This function calculates directed Nonlinear Interdependence M(X|Y) from 
two timeseries X and Y. Nonlinear Interdependence relies on state space 
reconstruction and Taken's theorem. It doesn't assume any strict 
functional relationship between dyniamics of the underlying system.
Exhanging X and Y will give M(Y|X), as it is a directional measure.

For more details refer to Andrzejak et. al. (2003).


#### Inputs:
`X`: first time series in 1-D vector

`Y`: second time series in 1-D vector

`k`: Number of nearest neighbours considered while calculating mean squared Euclidean distance Rk

`m`: Embedding dimension

#### Outputs:

`parameter.NLI_estimate`: NLI estimate (between 0 to 1)

`data.signal1`: X

`data.signal2`: Y


## Example usage
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

NOTE: Our work builds upon the code included in the following works and
implementations, so please do consider citing them:

#### References:
[1] Andrzejak, R. G., Kraskov, A., Stögbauer, H., Mormann, F., & Kreuz, T. (2003). Bivariate surrogate techniques: necessity, strengths, and caveats. Physical review E, 68(6), 066202.