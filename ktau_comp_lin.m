
% Script to compute the percentage of simulations (with linear risk) with
% a positive kendall tau value

% Import data

ac_struct = importdata('ac_data/ac_highkap_lin.txt');
ac = ac_struct.data;

sd_struct = importdata('sd_data/sd_highkap_lin.txt');
sd = sd_struct.data;
var = [sd(:,1),sd(:,2:end).^2];

cov_struct = importdata('cov_data/cov_highkap_lin.txt');
cov = cov_struct.data;


% Data labels
tVals = ac(:,1);
numSims = size(ac,2)-1;
numComps = size(ac,1);

% Proportion of time series to use from critical transition to use for 
% kendall tau computation (ideally we use 1)
tProp = 1;
tcompInit = numComps-floor(numComps*tProp)+1;



% Kendall tau - vector with ith component the kendall tau value for the ith
% simulation

ktau_ac = zeros(numSims,1);
ktau_var = zeros(numSims,1);
ktau_cov = zeros(numSims,1);


% run over simulations
for i = 1:numSims

% lag-1 ac
corMatrix_ac = corr(ac(tcompInit:end,[1,1+i]),'type','Kendall');
ktau_ac(i) = round(corMatrix_ac(1,2),2);

% sd
corMatrix_var = corr(var(tcompInit:end,[1,1+i]),'type','Kendall');
ktau_var(i) = round(corMatrix_var(1,2),2);

% cov
corMatrix_cov = corr(cov(tcompInit:end,[1,1+i]),'type','Kendall');
ktau_cov(i) = round(corMatrix_cov(1,2),2);

end


% Find proportion of kendall tau values that are positive

% vector to count number of positive kendall taus for each indicator
sum = [0,0,0];

for i=1:numSims
    if ktau_ac(i)>=0
        sum(1)= sum(1)+1;
    end
    
    if ktau_var(i)>=0
        sum(2)= sum(2)+1;
    end
    
    if ktau_cov(i)>=0
        sum(3)= sum(3)+1;
    end
        
end

% proportion of positive ktau values
ktau_prop = sum/numSims








