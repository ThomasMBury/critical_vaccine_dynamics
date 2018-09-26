
% Script to compute the percentage of simulations (with triangular risk) with
% positive kendall tau value before t=tsep years and negative kendall tau
% after t=tsep years

clear all 
close all

% Import data

ac_struct = importdata('ac_data/ac_highkap_tri_1mx.txt');
ac = ac_struct.data;

sd_struct = importdata('sd_data/sd_highkap_tri_1mx.txt');
sd = sd_struct.data;
var = [sd(:,1),sd(:,2:end).^2];

cov_struct = importdata('cov_data/cov_highkap_tri_1mx.txt');
cov = cov_struct.data;


% Data labels
tVals = ac(:,1);
numSims = size(ac,2)-1;
numComps = size(ac,1);


% Time that separates ktau computations
tinit = 45;
tsep = 65;
tfin = 85;
% Find the component of this time
[val,tsepIdx] = min(abs(tVals-tsep));
[val,tinitIdx] = min(abs(tVals-tinit));
[val,tfinIdx] = min(abs(tVals-tfin));



% Kendall tau - vector with ith component the kendall tau value for the ith
% simulation

ktau_ac_pre = zeros(numSims,1);
ktau_ac_post = zeros(numSims,1);
ktau_var_pre = zeros(numSims,1);
ktau_var_post = zeros(numSims,1);
ktau_cov_pre = zeros(numSims,1);
ktau_cov_post = zeros(numSims,1);



% run over simulations
for i = 1:numSims

% ac
corMatrix_ac_pre = corr(ac(tinitIdx:tsepIdx,[1,1+i]),'type','Kendall');
ktau_ac_pre(i) = round(corMatrix_ac_pre(1,2),2);

corMatrix_ac_post = corr(ac(tsepIdx:tfinIdx,[1,1+i]),'type','Kendall');
ktau_ac_post(i) = round(corMatrix_ac_post(1,2),2);


% sd
corMatrix_var_pre = corr(var(tinitIdx:tsepIdx,[1,1+i]),'type','Kendall');
ktau_var_pre(i) = round(corMatrix_var_pre(1,2),2);

corMatrix_var_post = corr(var(tsepIdx:tfinIdx,[1,1+i]),'type','Kendall');
ktau_var_post(i) = round(corMatrix_var_post(1,2),2);


% cov
corMatrix_cov_pre = corr(cov(tinitIdx:tsepIdx,[1,1+i]),'type','Kendall');
ktau_cov_pre(i) = round(corMatrix_cov_pre(1,2),2);

corMatrix_cov_post = corr(cov(tsepIdx:tfinIdx,[1,1+i]),'type','Kendall');
ktau_cov_post(i) = round(corMatrix_cov_post(1,2),2);
end



% Find proportion of simulations that have positive ktau before tsep and
% negative ktau after tsep

% vector to count successful hits
sum = [0,0,0];

for i=1:numSims
    if ktau_ac_pre(i)>=0 && ktau_ac_post(i)<=0
        sum(1)= sum(1)+1;
    end
    
    if ktau_var_pre(i)>=0 && ktau_var_post(i)<=0
        sum(2)= sum(2)+1;
    end
    
    if ktau_cov_pre(i)<=0 && ktau_cov_post(i)>=0
        sum(3)= sum(3)+1;
    end
        
end

% proportion of simulations with this property
ktau_prop = sum/numSims






