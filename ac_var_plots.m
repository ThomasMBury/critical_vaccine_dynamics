% Produce plots of AC and VAR averaged over realisations
% Also averages kendall trends

close all

% Import data
ac_struct = importdata('ac_data/ac_trans.txt');
ac = ac_struct.data;

var_struct = importdata('var_data/var_trans.txt');
var = var_struct.data;

trends_struct = importdata('trend_data/trends_trans.txt');
trends = trends_struct.data;

% Compute mean and sd of trends
mean_trends = mean(trends);
std_trends = std(trends);


% Set up plots
time_indices = var(:,1);
num_comps = size(var,2);

txt_var = ['Kendall \tau',' = ',num2str(mean_trends(1)),' ',setstr(177),' ',num2str(std_trends(1))];
txt_ac = ['Kendall \tau',' = ',num2str(mean_trends(2)),' ',setstr(177),' ',num2str(std_trends(2))];

txt_var_simple = ['\tau',' = ',num2str(mean_trends(1))];
txt_ac_simple = ['\tau',' = ',num2str(mean_trends(2))];




% Plot all realisations
figure(1)
plot(time_indices, var(:,2:num_comps))
xlabel('t (years)')
ylabel('Variance')

figure(2)
plot(time_indices, ac(:,2:num_comps))
xlabel('t (years)')
ylabel('AR1')



% Find mean and standard deviation
var_mean = mean(var(:,2:num_comps),2);
ac_mean = mean(ac(:,2:num_comps),2);

var_deviation = std(var(:,2:num_comps),0,2);
ac_deviation = std(ac(:,2:num_comps),0,2);



% Plot mean and standard deviation
figure(3)

pos = get(gcf, 'Position');     % Set figure size
set(gcf, 'Position', [pos(1) pos(2) 320 320])
shadedErrorBar(time_indices,var_mean,var_deviation,'b'); 
set(gca,'FontSize',12)          % Font size
xlabel('t (years)')
ylabel('Variance')
% set(gca,'YTick',[])           % Change ticks if necessary
% Plot range
xlow=0; xhigh=20; ylow=-inf; yhigh=inf;
axis([xlow inf ylow yhigh ])
% Trend text
text(0.8,0.9,txt_var_simple,'FontSize',12)


figure(4)

pos = get(gcf, 'Position');     % Set figure size
set(gcf, 'Position', [pos(1) pos(2) 320 320])  
shadedErrorBar(time_indices,ac_mean,ac_deviation,'g'); 
set(gca,'FontSize',12)          % Font size
xlabel('t (years)')
ylabel('AR1')
% Plot range
xlow=0; xhigh=inf; ylow=0.65; yhigh=0.95;
axis([xlow xhigh ylow yhigh ])
% Trend text
text(0.8,0.9,txt_ac_simple,'FontSize',12)


% Save figures

% print('Plots/plot_av1','-dpng','-r0')



