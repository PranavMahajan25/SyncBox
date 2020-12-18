# Weakly coupled oscillators tutorial
We demonstrate how to simulate weakly coupled oscillators with and without noise 
and utilize the toolbox functions to estimate synchronization measure estimates from noisy data.
We then compare PLV and coherence estimates with approximation of actual phase locking.
 
#### Initialization
 
```matlab
snr2 =1000;
trial_num=100;
coupling2 =0.75;   
detuning=3;
centerfreq=40;
triallength=1;
scale_noise =0;

snrs=0;
mfr= centerfreq; %main frequency of the first oscillator
snr= snr2;
snrs= snrs+1;
freqlin= mfr-detuning; % frequency of the second oscillator
nn=0;
ffr= freqlin;
nn=nn+1;
trt=0;
```
 
#### Generate data with and without noise (from simulation of osc)

```matlab
for trial=1:trial_num
    number_of_nodes=2; % Two oscillators
    initial_phase= [ randn(11)*2 randn(11)*2];  % Randomize initial phases
    tim_sec=triallength;
    time_steps=tim_sec+2; % The two extra seconds is due to transient dynamics at the beginning
    dt=0.001; % step size (here 1ms)
    phases = zeros(number_of_nodes,time_steps./dt);
    phases(1:2,1)= initial_phase(1:number_of_nodes,1).*1;
    clear noiseterm
    for ind=1:2
        noiseterm(ind,:)=powernoise(1,(time_steps./dt)+1,'normalize').*scale_noise;
    end

    f2=0;
    freqs2= ffr;
        f2=f2+1;
        cops=0;
        coupling= coupling2;
        cops=cops+1;
        K= [  coupling coupling];%coupling matrix (here symmetric)
        W= [ mfr freqs2];
        W=W.*(2*pi); %radians per sec
        K=K.*(2*pi); %scaling of coupling
		
        for time=2:time_steps./dt %%% SIMULATION of the phase-oscillators   
            for ind=1:number_of_nodes
                phases(ind,time)= phases(ind,time-1) + (dt*(W(ind))+ sum(dt.*K(:,ind).* -(sin((phases(ind,time-1) -phases(:,time-1)))) ) )+  noiseterm(ind,time-1) ;
            end
        end
        
        ph=  (mod(phases',2*pi))';
        xx=(exp(1i*(ph(:,1:1:end)))');
        
        % noise 
        noiseterm=randn(2,time_steps*1000).*((tim_sec*1000)/(2*sqrt(tim_sec*1000)));  % white noise properly scaled
        
        trials{trial} = ((real(xx)'))+((noiseterm).* 1./sqrt(snr)); %creating composite signal
        true_inst_ph{trial} =ph(:,2001:end);
        times{trial}=0.001:0.001:time_steps*1;
        trials{trial} = trials{trial}(:,2001:end); % ecluding the first seconds
        times{trial}=times{trial}(:,2001:end);
        xx2=(exp(1i*( angle(exp(1i*ph(1,2001:1:end))./exp(1i*ph(2,2001:1:end))) ))');
        % computation of phase dif on noisefree signal
        trialx(:,trial)=((xx2));
        disp(num2str(trial))
end
```

####  Actual Phase locking (approximation of theoretical value - noise free case)

``` matlab
allcoh2(nn,snrs)=abs(mean(trialx(:))); %% Approx. 'True value', here numerically estimated (but very close to analytically derived ones)     
SNR(nn,snrs)=snr;%(1/snr).^2;

Expected_Phase_locking = allcoh2;

```

#### Spectral Coherence estimate
``` matlab
X = [];
Y = [];
for trial = 1:trial_num
    X = [X; trials{trial}(1,:)];
    Y = [Y; trials{trial}(2,:)];
end

[parameters,data] = timeseriesCoherence(X, Y);

Coh = parameters.Coh_estimate;
```

#### Phase locking value (PLV) estimation
``` matlab
X1 = trials{1}(1,:);
Y1 = trials{1}(2,:);

[parameters, data]=timeseriesPLV(X1,Y1);
PLV = parameters.PLV_estimate;
```

#### Value comparison 
``` matlab
>> Expected_Phase_locking, PLV, Coh
Expected_Phase_locking =

    0.2978


PLV =

    0.2282


Coh =

    0.9396
```

#### Transfer Entropy (TE) estimation  (Rank method - simple binning)

``` matlab
t=2; w=2; % time lag 
l=1; k=1; % block lengths
[parameters, data] = timeseriesTE_rank(X1,Y1,l,k,t,w,128);

TE = parameters.TE_estimate;
```

#### References:
[1] Lowet, E., Roberts, M. J., Bonizzi, P., Karel, J., & De Weerd, P. (2016). Quantifying neural oscillatory synchronization: a comparison between spectral coherence and phase-locking value approaches. PloS one, 11(1)