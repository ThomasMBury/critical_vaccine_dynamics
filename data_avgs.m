% ---------------------------
% Trajectory Averages
%
% Script to investigate how trajectories behave on average
% 
% Tom Bury - July 2016
% ---------------------------


close all

% Import data
data_filt = importdata('data_filt.txt');
time_indices = data_filt(:,1);
wvals = data_filt(:,2);
wcrit = 2e-4;

% Construct vaccine data
sus_series = data_filt(:,3:3:end);
inf_series = data_filt(:,4:3:end);
vacc_series = data_filt(:,5:3:end);

% Find average and standard deviation
sus_mean = mean(sus_series,2);
sus_std = std(sus_series,0,2);

inf_mean = mean(inf_series,2);
inf_std = std(inf_series,0,2);

vacc_mean = mean(vacc_series,2);
vacc_std = std(vacc_series,0,2);


% Make a tri-plot

% Set figure size
set(gcf,'Units','Inches')
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) 10.5 6.5],'PaperPositionMode','Auto','PaperSize',[10.5 6.5])
ax1 = subplot(3,1,1); % top subplot
ax2 = subplot(3,1,2); % middle subplot
ax3 = subplot(3,1,3); % bottom subplot


% Plot mean Vaccinators
subplot(ax1)
shadedErrorBar(time_indices,vacc_mean,vacc_std,'r'); 
axis([-inf,inf,-inf,1])
set(gca,'FontSize',12)          % Font size
ylabel('Prop. Vaccinators')


% Plot all epidemics
subplot(ax2)
plot(time_indices,inf_series)
set(gca,'FontSize',12)          % Font size
ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[2,0,0])
ylabel('Prop. Infected')

% Plot risk function
subplot(ax3)
plot(time_indices,wvals,time_indices,ones(1,length(time_indices))*wcrit)
axis([-inf,inf,0,wcrit+2e-4])
set(gca,'FontSize',12)
ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[2,0,0])
xlabel('t (years)')
ylabel(ax3,'w(t)')
% legend
legend('w(t)','wcrit','Location','southeast');



% Plot susceptibles
figure()
shadedErrorBar(time_indices,sus_mean,sus_std,'b');
set(gca,'FontSize',12)          % Font size
ylabel('Prop. Susceptible')

figure()
plot(time_indices,sus_series)
ylabel('Prop. Susceptible')



% To save plot use:
% print('Plots/plot_','-dpdf','-r0')




