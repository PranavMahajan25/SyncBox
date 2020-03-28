## Transfer Entropy

`function [parameters, data] = timeseriesTE_rank(X,Y,l,k,t,w,Q)`

This function computes the transfer entropy between time series X and Y,
with the flow of information directed from X to Y, after ranking both 
X and Y. 
Probability density estimation is based on bin counting with fixed and 
equally-spaced bins. To enhance robustness against outliers and sparse 	
regions in the underlying distribution, we combine fixed binning with 
ordinal sampling (ranking).

For details, please see T Schreiber, "Measuring information transfer",
Physical Review Letters, 85(2):461-464, 2000.


#### Inputs:
`X`: first time series in 1-D vector

`Y`: second time series in 1-D vector

`l`: block length for X

`k`: block length for Y

`t`: time lag in X from present to where the block of length l ends

`w`: time lag in Y from present to where the block of length k ends

`Q`: number of quantization levels for both X and Y

#### Outputs:
`parameter.TE_estimate`: transfer entropy (bits)

`data.signal1`: X

`data.signal2`: Y


## Example usage
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

NOTE: Our work builds upon the code included in the following works and
implementations, so please do consider citing them:

#### References:
[1] Schreiber, T. (2000). Measuring information transfer. Physical review letters, 85(2), 461.

[2] Joon Lee et.al. 2012, Transfer Entropy Estimation and Directional
Coupling Change Detection in Biomedical Time Series. (Published in Biomed
Eng Online)
