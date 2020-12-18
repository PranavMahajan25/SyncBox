addpath('../paper_data/polarhist_phaseslip_data')

%% Log: Pranav 22/11/2020 
% This code will generate the Polar Histograms and Phase slip plots

clear all;
close all;
clc;

stepsize = 0.001;
comp_duration = 10;

% Analysis Parameters
start_ind = 1/stepsize +1; % simulation step at which to start spectral analysis [*startind*]
end_ind = start_ind+(comp_duration/stepsize +1);  % simulation step at which to end spectral analysis [*endind*]

Fs = 1000;
Fc1 = 1; % First Cutoff Frequency
Fc2 = 200; % Second Cutoff Frequency
N = 2;%10; % Order
h = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');
[B,A]=sos2tf(Hd.sosMatrix,Hd.Scalevalues);

%% Input freq = 2, Input amp = 5, With IN

inp_freq = 2;

load('voltage_ssvep_1_30_inp5.mat')
Vtcr_amp5 = filtfilt(B,A,Vtcravgmat(inp_freq,start_ind:end_ind));
Vtrn_amp5 = filtfilt(B,A,Vtrnavgmat(inp_freq,start_ind:end_ind));

phase_relation_wrapped_amp5 = get_delta_phase(Vtcr_amp5, Vtrn_amp5,1,1);
phase_relation_unwrapped_amp5 = unwrap(phase_relation_wrapped_amp5);

figure(1);polarhistogram(phase_relation_wrapped_amp5, 'FaceColor','blue','FaceAlpha',.3);

%% Input freq = 10, Input amp = 10, Without IN
inp_freq = 10;

load('voltage_ssvep_sansIN_1_30_inp10.mat')
Vtcr_sansIN_amp10 = filtfilt(B,A,Vtcravgmat(inp_freq,start_ind:end_ind));
Vtrn_sansIN_amp10 = filtfilt(B,A,Vtrnavgmat(inp_freq,start_ind:end_ind));

phase_relation_wrapped_sansIN_amp10 = get_delta_phase(Vtcr_sansIN_amp10, Vtrn_sansIN_amp10,1,1);
phase_relation_unwrapped_sansIN_amp10 = unwrap(phase_relation_wrapped_sansIN_amp10);

figure(2);polarhistogram(phase_relation_wrapped_sansIN_amp10, 'FaceColor','red','FaceAlpha',.3);


%% Plotting phase slips 
figure(3);
plot(timevec(start_ind:end_ind), phase_relation_unwrapped_amp5, 'LineWidth',2);
hold on;
plot(timevec(start_ind:end_ind), phase_relation_unwrapped_sansIN_amp10, 'LineWidth',2);
ylabel('Phase relation unwrapped (radians)')
xlabel('Time (seconds)')
grid on,box off
legend('',''),legend box off



function phase_relation_wrapped = get_delta_phase(Vtcr, Vtrn,n,m)
    p_TCR=angle(hilbert((Vtcr)));
    p_TRN=angle(hilbert((Vtrn)));
    
    phase_relation_wrapped = angle(exp(1i*n*p_TCR)./exp(1i*m*p_TRN));
end