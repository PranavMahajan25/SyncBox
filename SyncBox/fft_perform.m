function  [ft] = fft_perform(lfp)
 
Fs=1000;
trial_number= length(lfp.trial);
for tr=1: trial_number
L=length(lfp.trial{tr});
y=(lfp.trial{tr});   
wins=hanning(length(y));
Y = 2.*(fft(y,L,2)./L);
f = Fs/2*linspace(0,1,L/2+1);
ft.fourierspctrm(tr,:,:) = Y(:,1:L/2+1);
ft.freq=f;
end