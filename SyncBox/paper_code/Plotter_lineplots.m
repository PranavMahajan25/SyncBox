addpath('../paper_data/lineplot_data')

%% Log: 21-11-2020: Modified and adapted for arXiv paper by BSB
% Harcoded for input impulse amplitude 5 and 10 and frequency between 1 to 30 hz
% Originally Authored by: Pranav Mahajan - 19/11/2020

%% This code will generate the Line Plots from the arXiv paper
% This code loads the pre-computed synchronization measures data obtained
% by running our toolbox on the LGN neural mass model with and without IN.

clear all
% close all
clc
%% Load data: Either
% load syncdata_withoutIN.mat
%% Load data: or
load syncdata_withIN.mat 


%% PLOTTING MEAN AND STD OF PLV OVER MULTIPLE TRIALS
for i = 1:size(PLV_cell,2)
    amp5PLV(i,:) = PLV_cell{i}(1,:);
    amp10PLV(i,:) = PLV_cell{i}(2,:);
end
meanPLVmat(1,:)=mean(amp5PLV,1);
meanPLVmat(2,:)=mean(amp10PLV,1);
stdPLVmat(1,:)=std(amp5PLV,1);
stdPLVmat(2,:)=std(amp10PLV,1);
figure,errorbar(meanPLVmat(1,:),stdPLVmat(1,:))
hold on, errorbar(meanPLVmat(2,:),stdPLVmat(2,:))
ylabel('PLV')
xlabel('Freq(Hz)')
grid on,box off
legend('k=5','k=10')


%% PLOTTING MEAN AND STD OF MI OVER MULTIPLE TRIALS
for i = 1:size(MI_cell,2)
    amp5MI(i,:) = MI_cell{i}(1,:);
    amp10MI(i,:) = MI_cell{i}(2,:);
end
meanMImat(1,:)=mean(amp5MI,1);
meanMImat(2,:)=mean(amp10MI,1);
stdMImat(1,:)=std(amp5MI,1);
stdMImat(2,:)=std(amp10MI,1);
figure,errorbar(meanMImat(1,:),stdMImat(1,:))
hold on, errorbar(meanMImat(2,:),stdMImat(2,:))
ylabel('MI')
xlabel('Freq(Hz)')
grid on,box off
legend('k=5','k=10')


%% PLOTTING MEAN AND STD OF COHERENCE OVER MULTIPLE TRIALS
for i = 1:size(Coh_cell,2)
    amp5Coh(i,:) = Coh_cell{i}(1,:);
    amp10Coh(i,:) = Coh_cell{i}(2,:);
end
meanCohmat(1,:)=mean(amp5Coh,1);
meanCohmat(2,:)=mean(amp10Coh,1);
stdCohmat(1,:)=std(amp5Coh,1);
stdCohmat(2,:)=std(amp10Coh,1);
figure,errorbar(meanCohmat(1,:),stdCohmat(1,:))
hold on, errorbar(meanCohmat(2,:),stdCohmat(2,:))
ylabel('Coh')
xlabel('Freq(Hz)')
grid on,box off
legend('k=5','k=10')


%% PLOTTING MEAN AND STD OF Shannon Entropy OVER MULTIPLE TRIALS
for i = 1:size(rho_cell,2)
    amp5rho(i,:) = rho_cell{i}(1,:);
    amp10rho(i,:) = rho_cell{i}(2,:);
end
meanrhomat(1,:)=mean(amp5rho,1);
meanrhomat(2,:)=mean(amp10rho,1);
stdrhomat(1,:)=std(amp5rho,1);
stdrhomat(2,:)=std(amp10rho,1);
figure,errorbar(meanrhomat(1,:),stdrhomat(1,:))
hold on, errorbar(meanrhomat(2,:),stdrhomat(2,:))
ylabel('rho')
xlabel('Freq(Hz)')
grid on,box off
legend('k=5','k=10')

%% PLOTTING MEAN AND STD OF Lambda OVER MULTIPLE TRIALS
for i = 1:size(lambda_cell,2)
    amp5lambda(i,:) = lambda_cell{i}(1,:);
    amp10lambda(i,:) = lambda_cell{i}(2,:);
end
meanlambdamat(1,:)=mean(amp5lambda,1);
meanlambdamat(2,:)=mean(amp10lambda,1);
stdlambdamat(1,:)=std(amp5lambda,1);
stdlambdamat(2,:)=std(amp10lambda,1);
figure,errorbar(meanlambdamat(1,:),stdlambdamat(1,:))
hold on, errorbar(meanlambdamat(2,:),stdlambdamat(2,:))
ylabel('lambda')
xlabel('Freq(Hz)')
grid on,box off
legend('k=5','k=10')
