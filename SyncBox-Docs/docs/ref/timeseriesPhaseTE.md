## Phase Transfer Entropy

`function [parameters, data] = timeseriesPhaseTE(X, Y, delay, binsize)`

This function computes the Phase transfer entropy (TE) and  differential Phase TE between time series X and Y,
with the flow of information directed from X to Y. 
Uses phase-space binning method combined with trial collapsing
(Gómez-Herrero et al., 2010, Wilmer et al., 2012).
Bin width was defined according to Scott's choice (Scott, 1992).


#### Input:
`X`: first time series in 1-D vector

`Y`: second time series in 1-D vector

`delay`: prediction delay in samples; leave empty if you want the delay to be based on the frequency content of the data

`binsize`: binsize for the histograms of phase occurances; provide a number, or 'scott' or 'otnes' to use the approach by Scott or by Otnes and Enochson

#### Outputs:

`parameter.PTE_estimate`: Phase transfer entropy (bits)

`parameter.dPTE_estimate`: Phase differential transfer entropy (normalized between 0 to 1)

`data.signal1`: X

`data.signal2`: Y



## Example usage
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

NOTE: Our work builds upon the code included in the following works and
implementations, so please do consider citing them:

#### References:
[1] M Lobier, F Siebenhuhner, S Palva, JM Palva (2014) Phase transfer entropy
: a novel phase-based measure for directed connectivity in networks 
coupled by oscillatory interactions. Neuroimage 85, 853-872
with implemementation inspired by Java code by C.J. Stam 
(https://home.kpn.nl/stam7883/brainwave.html)

