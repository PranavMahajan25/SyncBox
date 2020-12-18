## Mutual Information

`function [parameters, data] = timeseriesMI_kernel(X, Y, h, ind)`

Mutual information is an information-theoretic measure that can quantify non-linear dependencies between systems, unlike linear cross-correlation.
It quantifiesthe amount of information about one system obtained by knowing about theother system
This function computes the Kernel-based estimate for mutual information 
I(X, Y) between time series X and Y.
Data is first copula-transformed, then marginal and joint probability 
distributions are estimated using Gaussian kernels.



#### Inputs:
`X`: first time series in 1-D vector

`Y`: second time series in 1-D vector

`h`: kernel width

`ind`: subset of data on which to estimate MI

#### Outputs:
`parameter.MI_estimate`: Mutual information (bits)

`parameter.kernel_width`: kernel width 'h'

`data.signal1`: X

`data.signal2`: Y




## Example usage
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

NOTE: Our work builds upon the code included in the following works and
implementations, so please do consider citing them:

#### References:
[1] Mikhail (2020). Kernel estimate for (Conditional) Mutual Information (https://www.mathworks.com/matlabcentral/fileexchange/30998-kernel-estimate-for-conditional-mutual-information), 
MATLAB Central File Exchange. Retrieved March 20, 2020. 
