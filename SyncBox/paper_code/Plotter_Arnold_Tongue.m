addpath('../paper_data/arnold_tongue_data')
load('PLV_TCR_TRN_fundamental_100x15_Impulse_input.mat')

figure;
pcolor(linspace(1,100,100), linspace(15,1,15), p1)
colormap(parula)
title('TCR-TRN (PLV) - Amplitude vs Freq');
xlabel('Freq (varies with 1, ranges from 1 to 100)'),
ylabel('Amplitude (varies with 1, ranges from 1 to 15)');

