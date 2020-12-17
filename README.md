# SyncBox 

SyncBox is a MATLAB toolbox for synchronization measures. We implement synchronization measures which can be used to quantify the synchronization between two(or more) signals.

For more information, see the accompanying [research paper](https://arxiv.org/abs/2012.06112).
For more details about the algorithms and usage refer to the [docs](https://pranavmahajan25.github.io/SyncBox/)

## Install

Prerequisites:
- MATLAB 2014b or newer versions
- Signal Processing toolbox

To install, clone the repository by proceeding to your working directory and typing the following command in your terminal window,

```git
git clone https://github.com/PranavMahajan25/SyncBox.git
```

or download zip by clicking on the **Code** button at the top and unzip it in your working directory.

The synchronization measures can be found in SyncBox->SyncBox->toolbox(refer to the folder structure below). You can start using the functions right away! Check out the tutorials or refer to function descriptions in the [docs](https://pranavmahajan25.github.io/SyncBox/)

## Measures

SyncBox implements a total of 9 synchronization measures (6 symmetric and 3 directional measures). These measures computed from the time series data can be used to investigate dynamical systems treating them as blackboxes. Our work is largely influenced and organized as per the review chapter by Thomas Kreuz [1]. The following measures are included in SyncBox,

Symmetric:

- Spectral Coherence
- Phase locking value
- Normalised Shannon Entropy
- Lambda Synchronization Index
- Mutual Information
- Cross correlation

Directional:

- Transfer entropy
- Phase transfer entropy (PTE) and differential PTE
- Directed Nonlinear Interdependence

For details about the measures, refer to the [docs](https://pranavmahajan25.github.io/SyncBox/).

## Directory Structure	

The SyncBox directory has the required code. You can ignore the SyncBox-Docs folder.

```bash
SyncBox
├── paper_code
├── paper_data
│   ├── arnold_tongue_data
│   ├── lineplot_data
│   └── polarhist_phaseslip_data
├── toolbox
└── tutorials
```

This directory contains all the code files necessary to use the SyncBox measures, as well as generate the results we have detailed in our [paper](https://arxiv.org/abs/2012.06112).

The directory `paper_code` has the code files to generate the plots in the paper. These plots include:
- Arnold Tongue plots for the PLV measure between the TCR and TRN neuronal population signals in a computational model of the LGN in the brain(Fig 4 in the paper).
- Line plots which show the variation of the PLV, Normalised Shannon Entropy, Lambda Index, and the Spectral Coherence between the signals from TCR and TRN in the LGN model(Fig 3 in the paper).
- Polar histograms which provide a way to visualize the synchronization between the two signals(Fig 6 in the paper).

The directory `paper_data` has `.mat` data files which are used to create the plots generated by the code files in `paper_code`. It has three subdirectories corresponding to each of the three plots listed above. We have only included the data from the model, and not the model itself.

The directory `toolbox` is the main directory. This folder contains the code files for all the synchronization measures as well as the additional utilities. The synchronization measure code files are named as `timeseries<MeasureName>`, e.g. timeseriesPLV.m or timeseriesLambda.m. The 9 `timeseriesX.m` code files correspond to the 9 synchronization measures.

Finally, the directory `tutorials` contains code and data files for two tutorials on using the synchronization measures. The first tutorial estimates the synchronization between two weakly coupled oscillators. The second measures the synchronization between signals from the TCR and TRN neuronal populations in a computational model of the LGN in the brain. You can find the tutorials in the [docs](https://pranavmahajan25.github.io/SyncBox/).

## Popular Function Descriptions

Here we describe some of the measures we have implemented. For a full description refer to the [docs](https://pranavmahajan25.github.io/SyncBox/)

### timeseriesPLV

`function [parameters, data] = timeseriesPLV(X,Y)`

This function computes the Phase locking value between time series X & Y. It uses Hilbert transform for phase extraction. After extracting phases from both timeseries, instantaneous phase relation is computed in order to estimate PLV.

#### Inputs:
`X`: first time series in 1-D vector
`Y`: second time series in 1-D vector

#### Outputs:
`parameter.PLV_estimate`: PLV estimate (between 0 to 1)
`data.signal1`: X
`data.signal2`: Y

### timeseriesShannonEntropy

`function [parameters, data] = timeseriesShannonEntropy(X, Y, m, n)`

This function computes the Normalized Shannon Entropy sync measure between time series X & Y, for m:n synchronization. It uses Hilbert transform for Phase extraction. After extracting phases from both timeseries, the Shannon entropy of the phase relation histogram is calculated. This value is normalized by the maximum possible Shannon entropy for the histogram.

#### Inputs:

`X`: first time series in 1-D vector
`Y`: second time series in 1-D vector
`m`: multiple for the first signal, default is 1
`n`: multiple for the second signal, default is 1

#### Outputs:
`parameter.ShannonEntropy_estimate`: normalaised Shannon Entropy estimate (between 0 to 1)
`data.signal1`: X
`data.signal2`: Y

### timeseriesLambda

`function [parameters, data] = timeseriesLambda(X, Y, m, n)`

This function computes the Lambda synchronization measure value between time series X & Y, for m:n synchronization. We use Hilbert transform for Phase extraction. After extracting phases from both timeseries, the method detailed in Rosenblum et al. is followed to calculate the Lambda Synchronization Index using a stroboscopic approach.

#### Inputs:
`X`: first time series in 1-D vector
`Y`: second time series in 1-D vector
`m`: multiple for the first time series, default is 1
`n`: multiple for the second time series, default is 1

#### Outputs:

`parameter.Lambda_estimate` : Lambda measure estimate (between 0 to 1)
`data.signal1` : X
`data.signal2` : Y

### timeseriesCoherence

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

# SyncBox
A synchronization measures toolbox
