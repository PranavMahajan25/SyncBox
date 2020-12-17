function [parameters, data] = timeseriesTE_rank(X,Y,l,k,t,w,Q)

%%%%%
% This function computes the transfer entropy between time series X and Y,
% with the flow of information directed from X to Y, after ranking both 
% X and Y. 
% Probability density estimation is based on bin counting with fixed and 
% equally-spaced bins. To enhance robustness against outliers and sparse 
% regions in the underlying distribution, we combine fixed binning with 
% ordinal sampling (ranking).
% 
% For details, please see T Schreiber, "Measuring information transfer",
% Physical Review Letters, 85(2):461-464, 2000.
%
% Inputs:
% X: first time series in 1-D vector
% Y: second time series in 1-D vector
% l: block length for X
% k: block length for Y
% t: time lag in X from present to where the block of length l ends
% w: time lag in Y from present to where the block of length k ends
% Q: number of quantization levels for both X and Y
% 
% Outputs:
% parameter.TE_estimate: transfer entropy (bits)
% data.signal1: X
% data.signal2: Y
%
%
% NOTE: Our work builds upon the code included in the following work, so
% please do consider citing it.
%
% References:
% Joon Lee et.al. 2012, Transfer Entropy Estimation and Directional
% Coupling Change Detection in Biomedical Time Series. (Published in Biomed
% Eng Online)
% 
%
% Copyright 2011 Joon Lee
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%%%%%

%% check input arguments
if nargin < 2
    error('Please provide input data in format X and Y timeseries');
end
if nargin < 6
t=2; w=2; % time lag 
l=1; k=1; % block lengths
end
if nargin < 7
t=2; w=2; % time lag 
l=1; k=1; % block lengths
Q=128;
end

%% Code

X = reshape(X, [1, length(X)]);
Y = reshape(Y, [1, length(Y)]);

X=X(:)';
Y=Y(:)';

% ordinal sampling (ranking)
Nt=length(X);
[B,IX]=sort(X);
X(IX)=1:Nt;
[B,IX]=sort(Y);
Y(IX)=1:Nt;


% quantize X and Y according to fixed, equally-spaced bins
Xq=quantentr(X,Q); 
Yq=quantentr(Y,Q);


% go through the time series X and Y, and populate Xpat, Ypat, and Yt
Xpat=[]; Ypat=[]; Yt=[];
codeX=(Q.^((l-1):-1:0))';
codeY=(Q.^((k-1):-1:0))';

for i=max([l+t k+w]):1:min([length(Xq) length(Yq)])
    Xpat=[Xpat; Xq(i-l-t+1:i-t)*codeX];
    Ypat=[Ypat; Yq(i-k-w+1:i-w)*codeY];
    Yt=[Yt; Yq(i)];    
end

% compute transfer entropy
T=0;
idxDone=[];
N=length(Xpat);
for i=1:N
    if ~any(i==idxDone)        
        p1=sum(Xpat==Xpat(i) & Ypat==Ypat(i) & Yt==Yt(i))/N;
        p2=sum(Xpat==Xpat(i) & Ypat==Ypat(i) & Yt==Yt(i))/sum(Xpat==Xpat(i) & Ypat==Ypat(i));
        p3=sum(Ypat==Ypat(i) & Yt==Yt(i))/sum(Ypat==Ypat(i));
        T=T+p1*log2(p2/p3);        
        idxDone=[idxDone; find(Xpat==Xpat(i) & Ypat==Ypat(i) & Yt==Yt(i))];
        idxDone=unique(idxDone);
    end
end

parameters.TE_estimate = T;
data.signal1 = X;
data.signal2 = Y;
end


