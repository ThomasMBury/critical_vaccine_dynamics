
%--------------------------------------
% Import and collate data for Demetri
%--------------------------------------


clear all 
close all


%-----------Import relevant files------------

%--------For x---------------

% lag-1 ac
ac_struct = importdata('ac_data/ac_highkap_tri.txt');
ac = ac_struct.data;

% variance
sd_struct = importdata('sd_data/sd_highkap_tri.txt');
sd = sd_struct.data;
var = [sd(:,1),sd(:,2:end).^2];

% COV
cov_struct = importdata('cov_data/cov_highkap_tri.txt');
cov = cov_struct.data;


% ------- For 1-x----------

% lag-1 ac
ac1mx_struct = importdata('ac_data/ac_highkap_tri_1mx.txt');
ac1mx = ac1mx_struct.data;

% variance
sd1mx_struct = importdata('sd_data/sd_highkap_tri_1mx.txt');
sd1mx = sd1mx_struct.data;
var1mx = [sd1mx(:,1),sd1mx(:,2:end).^2];

% COV
cov1mx_struct = importdata('cov_data/cov_highkap_tri_1mx.txt');
cov1mx = cov1mx_struct.data;




%------------Calculate mean and standard deviation-----------

num_comps = size(ac,2);
tVals = ac(:,1);

% For x
ac_mean_tri = mean(ac(:,2:num_comps),2);
ac_deviation_tri = std(ac(:,2:num_comps),0,2);

var_mean_tri = mean(var(:,2:num_comps),2);
var_deviation_tri = std(var(:,2:num_comps),0,2);

cov_mean_tri = mean(cov(:,2:num_comps),2);
cov_deviation_tri = std(cov(:,2:num_comps),0,2);


% For 1-x
ac1mx_mean_tri = mean(ac1mx(:,2:num_comps),2);
ac1mx_deviation_tri = std(ac1mx(:,2:num_comps),0,2);

var1mx_mean_tri = mean(var1mx(:,2:num_comps),2);
var1mx_deviation_tri = std(var1mx(:,2:num_comps),0,2);

cov1mx_mean_tri = mean(cov1mx(:,2:num_comps),2);
cov1mx_deviation_tri = std(cov1mx(:,2:num_comps),0,2);





%---------------Collate into single arrays-----------------%

data_x = [tVals,ac_mean_tri, var_mean_tri,cov_mean_tri,ac_deviation_tri,var_deviation_tri,cov_deviation_tri];
data_1mx = [tVals,ac1mx_mean_tri, var1mx_mean_tri,cov1mx_mean_tri,ac1mx_deviation_tri,var1mx_deviation_tri,cov1mx_deviation_tri];



%-----------------Export as a csv file---------------------%

csvwrite('sim_data/data_fig3_x.csv',data_x)
csvwrite('sim_data/data_fig3_1mx.csv',data_1mx)




%-------------Collection of 10 random realisations-------------%

num_comps=size(ac,2)-1;
% select 10 random numbers between 2 and num_comps
rng(300)
set=ceil(rand(10,1)*(num_comps-1)+1);

ac_set=ac(:,set);
var_set=var(:,set);
cov_set=cov(:,set);

ac1mx_set=ac1mx(:,set);
var1mx_set=var1mx(:,set);
cov1mx_set=cov1mx(:,set);


rand_set_x = [tVals,ac_set,var_set,cov_set];
rand_set_1mx = [tVals,ac1mx_set,var1mx_set,cov1mx_set];


%-----------------Export as a csv file---------------------%

csvwrite('sim_data/fig3_randset_x.csv',rand_set_x)
csvwrite('sim_data/fig3_randset_1mx.csv',rand_set_1mx)



% Plots

figure(1)
plot(tVals,ac_set)
figure(2)
plot(tVals,var_set)
figure(3)
plot(tVals,cov_set)

figure(4)
plot(tVals,ac1mx_set)
figure(5)
plot(tVals,var1mx_set)
figure(6)
plot(tVals,cov1mx_set)






%---------------Export this data---------------%

% csvwrite('sim_data/data_fig3_x.csv',data_x)
% csvwrite('sim_data/data_fig3_1mx.csv',data_1mx)
% 





