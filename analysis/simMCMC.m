% simulate n-reward task with MCMC
clear all
addpath ../../../June2016/Discrete/

q = .8;
beta = 10;
Nsamp = 10;

% load data to get probability of reward for each button push
fname = '../data/id1_block3_nchoice4.csv';
pRwd = dlmread(fname,',',1,6)';


[u rwd] = genSamplesMCMC_discrete([q beta],pRwd,Nsamp,'metropolis')

%% visualize policy
[p_1 p_2 N_1 N_2] = getSwitchPolicy(u(1,:),rwd(1,:));
plotSwitchPolicy(p_2,N_2,2)