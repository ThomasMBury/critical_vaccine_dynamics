% Script to plot column of time series for Demetri's paper
% Version using lag1-AC

clear
close all

% Import data files

sim_data = importdata('sim_data/simdata_noepi.txt');
wcrit = 5e-4;
tmax = 60;


% lots of plotnumbers
plot_num=48;

figure(2)

% Specifications
lw = 1; % line width
nudgeup = 0.008; % shift figures up to reduce vertical space
fs = 9; % font size for axes
fsl = 9; % font size for legend

% Set figure size
set(gcf,'Units','Centimeters')
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) 10 10],'PaperPositionMode','Auto',...
    'PaperUnits','Centimeters','PaperSize',[10 10],...
    'PaperPosition',[0 0 10 10]) %[left bottom width height]


ax1 = subplot(4,1,1); % plot 1
ax2 = subplot(4,1,2); % plot 2
ax3 = subplot(4,1,3); % plot 3
ax4 = subplot(4,1,4); % plot 4

% Reduce vertical spacing between plots
p = get(ax2, 'pos');
p(2) = p(2) + nudgeup;
set(ax2,'pos',p);

p = get(ax3, 'pos');
p(2) = p(2) + 2*nudgeup;
set(ax3,'pos',p);

p = get(ax4, 'pos');
p(2) = p(2) + 3*nudgeup;
set(ax4,'pos',p);



% figure label position
labx = 0.02;
laby = 0.87;


% time column
t = sim_data(:,1);



%------------------------
% plot 1 - risk function
%------------------------

subplot(ax1)

plot(t,sim_data(:,2),'Color','k','DisplayName','w(t)','LineWidth',lw)
axis([-inf,inf,0,7e-4])
set(gca,'xticklabel',[],'FontSize',fs,'YColor','k')

hold on
plot(t,ones(1,length(t))*wcrit,':k','DisplayName','wcrit','LineWidth',lw)

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[0,0,0])
ylabel('w')


% legend
% legend('show','FontSize',fsl,'Location','southeast');

% subfigure label
text(labx,laby,'a','Units','normalized','FontWeight','bold','FontSize',fs)


hold off

%-----------------------------
% plot 2 - disease dynamics
%-----------------------------

subplot(ax2)

yyaxis left
plot(t,sim_data(:,3*plot_num+2),'b','LineWidth',lw)
axis([-inf,inf,0.7,1])
set(gca,'xticklabel',[],'FontSize',fs,'YColor','b')

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[0,0,0])
ylabel('x') % proportion of newborns getting vaccinated


yyaxis right
plot(t,sim_data(:,3*plot_num+1),'r','LineWidth',lw)
set(gca,'YColor','r')
axis([-inf,inf,0,1e-6])
% change ticks
% ax = gca;
% ax.YTick = [0,2e-7,4e-7,6e-7,8e-7];
% ax.YTickLabel = {'0','2','4','6','8'};

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[1,0,0])
ylabel('I')

% base
% text(56,11.5e-7,'\times10^{-7}','Color','r','FontSize',fs)

% subfigure label
text(labx,laby,'b','Units','normalized','FontWeight','bold','FontSize',fs)


%------------------------
% Plot 3 - Variance of x
%------------------------

% set up grid
subplot(ax3)

% Import data
var_struct = importdata('sd_data/sd_noepi_x.txt');
var_temp = var_struct.data;

% Work with data up to tcrit
    tcrit = 40;
    time_indices = var_temp(:,1);
    temp = abs(time_indices-tcrit);
    [val,idx] = min(temp);
    var = var_temp(1:idx,:);


% Find mean and standard deviation
num_comps = size(var,2);
var_mean = mean(var(:,2:num_comps),2);
var_deviation = std(var(:,2:num_comps),0,2);

% Stop plot at t=tcrit i.e where threshold is passed
time_indices = var(:,1);

% Find Kendall Tau of mean ac (2dp)
[corMatrix,pvals] = corr([time_indices,var_mean],'type','Kendall');
ktau_lin = round(corMatrix(1,2),2);

% plot with shaded error bars
shadedErrorBar(time_indices,var_mean,var_deviation,'k'); 


% Plot range
xlow=0; xhigh=tmax; ylow=1.6e-3; yhigh=inf;
axis([xlow xhigh ylow yhigh ])

% Specifications
set(gca,'FontSize',fs,'xticklabel',[],'YColor','k')
% change ticks
ax = gca;
% ax.YTick = [0.6,0.7,0.8];
ylabp = get(gca,'YLabel'); % move y label to the right
set(ylabp,'Position',get(ylabp,'Position')+[0,0,0])
ylabel('SD(x)')

% Draw window arrow
xpos_arrow = [0.135,0.26];
ypos_arrow = [0.38,0.38];
xpos_text = 10;
ypos_text = 0.755; 

annotation('doublearrow',xpos_arrow,ypos_arrow,'LineWidth',0.3,...
    'Head1Width',5,'Head2Width',5,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',5,'Head2Length',5)

% Kendall tau text
ktxt = ['\tau = ',num2str(ktau_lin,'%.2f')];
text(0.82,0.16,ktxt,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')


% subfigure label
text(labx,laby,'c','Units','normalized','FontWeight','bold','FontSize',fs)



%------------------------
% Plot 4 - Variance of I
%------------------------

% set up grid
subplot(ax4)


% Import data
var_struct = importdata('sd_data/sd_noepi_i.txt');
var_temp = var_struct.data;

% Work with data up to tcrit
    tcrit = 40;
    time_indices = var_temp(:,1);
    temp = abs(time_indices-tcrit);
    [val,idx] = min(temp);
    var = var_temp(1:idx,:);


% Find mean and standard deviation
num_comps = size(var,2);
var_mean = mean(var(:,2:num_comps),2);
var_deviation = std(var(:,2:num_comps),0,2);

% Stop plot at t=tcrit i.e where threshold is passed
time_indices = var(:,1);

% Find Kendall Tau of mean ac (2dp)
[corMatrix,pvals] = corr([time_indices,var_mean],'type','Kendall');
ktau_lin = round(corMatrix(1,2),2);

% plot with shaded error bars
shadedErrorBar(time_indices,var_mean,var_deviation,'k'); 


% Plot range
xlow=0; xhigh=tmax; ylow=-inf; yhigh=inf;
axis([xlow xhigh ylow yhigh ])

% Specifications
set(gca,'FontSize',fs,'YColor','k')
% change ticks
ax = gca;
% ax.YTick = [0.6,0.7,0.8];
ylabp = get(gca,'YLabel'); % move y label to the right
set(ylabp,'Position',get(ylabp,'Position')+[0,0,0])
ylabel('SD(I)')
xlabel('Time (years)')


% Draw window arrow
xpos_arrow = [0.135,0.26];
ypos_arrow = [0.17,0.17];
xpos_text = 10;
ypos_text = 0.755; 

annotation('doublearrow',xpos_arrow,ypos_arrow,'LineWidth',0.3,...
    'Head1Width',5,'Head2Width',5,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',5,'Head2Length',5)

% Kendall tau text
ktxt = ['\tau = ',num2str(ktau_lin,'%.2f')];
text(0.82,0.16,ktxt,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')


% subfigure label
text(labx,laby,'d','Units','normalized','FontWeight','bold','FontSize',fs)



%-------------------
% Export the beast
%-------------------

 %Export at 300 dpi 
 % print('../../Research/vaccine_behaviour_16/demetri_figures/fig_ews_I','-dpdf','-r300')



