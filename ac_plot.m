% AC plot over full time range

% Import data
ac_struct = importdata('ac_data/ac_lin.txt');
ac = ac_struct.data;

% Find mean and standard deviation
num_comps = size(ac,2);
ac_mean = mean(ac(:,2:num_comps),2);
ac_deviation = std(ac(:,2:num_comps),0,2);

% plot

time_indices = ac(:,1);

figure()


pos = get(gcf, 'Position');     % Set figure size
set(gcf, 'Position', [pos(1) pos(2) 320 320])  
shadedErrorBar(time_indices,ac_mean,ac_deviation,'g'); 
set(gca,'FontSize',12)          % Font size
xlabel('t (years)')
ylabel('AR1')
% Plot range
xlow=0; xhigh=100; ylow=-inf; yhigh=inf;
axis([xlow xhigh ylow yhigh ])
