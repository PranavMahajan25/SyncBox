function [parameters, data]=timeseriesCoherence(X,Y,n)
%%%%%
% This function computes the Spectral Coherence between 'n' trials of 
% 2 time series X & Y
%
% Inputs:
% X: n trials of first time series in 2-D vector [n x m]
% Y: n trials of second time series in 2-D vector [n x m]
% where n is the number of trials and m is the number of datapoints in a
% single timeseries.
%
% Outputs:
% parameter.Coh_estimate: Coherence estimate (between 0 to 1)
% data.trial: X and Y trials in cell format 
%
% Author: Pranav Mahajan
%
% NOTE: Our work builds upon the code included in the following works and
% implementations, so please do consider citing them:
% 
% References:
% Lowet, E., Roberts, M. J., Bonizzi, P., Karel, J., & De Weerd, P. (2016).
% Quantifying neural oscillatory synchronization: a comparison between 
% spectral coherence and phase-locking value approaches. PloS one, 11(1)
%%%%%
%% check input arguments
if nargin < 2
    error('Please provide input data in format n trials of X and Y timeseries');
end
%% check input arguments
if nargin < 3
    n = size(X,1);
end

for trial = 1:n
    trials{trial}(1,:) = X(trial, :);
    trials{trial}(2,:) = Y(trial, :);
end

data=[];
data.trial=trials; % trials is 1xn, but trials{trial} = 2xlength

freq1=fft_perform(data); % performing FFT 

allfrs(:,:,1,1)=   squeeze(mean(((freq1.fourierspctrm(:,:,:)).*conj((freq1.fourierspctrm(:,:,:))))))  ; %computing power

crossspectra=squeeze(freq1.fourierspctrm(:,1,:)).*conj(squeeze(freq1.fourierspctrm(:,2,:)))  ;
autospectra1=squeeze(freq1.fourierspctrm(:,1,:)).*conj(squeeze(freq1.fourierspctrm(:,1,:)))  ;
autospectra2=squeeze(freq1.fourierspctrm(:,2,:)).*conj(squeeze(freq1.fourierspctrm(:,2,:)))  ;
Coh_estimate=abs(mean(crossspectra./sqrt(autospectra1.*autospectra2),1));

allcoh(:,1,1)=  Coh_estimate;  

cohest=max(allcoh); % find the maximum peak in the PLV spectra
cohest=squeeze(cohest);

parameters.Coh_estimate = cohest;
end


