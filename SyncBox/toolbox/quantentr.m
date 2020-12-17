function xquant = quantentr(x,quantlvl)

%%%%%
% The function quantentr quantizes the signal x into quantlvl levels using
% a codebook defined by [0:1:quantlvl-1].
%
% Inputs:
% x - input signal
% quantlvl - a number of quantization levels
%
% Output:
% xquant - a quantized version of the input signal
%
%
% Copyright 2010 Joon Lee, Ervin Sejdic, Louis Mayaud
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


%Q = prctile(x,[5 95]);
%xmin=Q(1);
%xmax=Q(2);
xmin=min(x);
xmax=max(x);
quantstep = (xmax-xmin)/quantlvl;
if quantstep == 0
    xquant=zeros(size(x));
else
    partition = (xmin+quantstep):quantstep:(xmax-quantstep);
    xquant = quantiz(x,partition,(0:1:quantlvl-1));
end


% end of function
