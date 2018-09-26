% Script to plot column of time series for Demetri's paper
% Version using lag1-AC

clear
close all

% Import data files

simdata_lin = importdata('sim_data/simdata_erlang_lin.txt');
simdata_tri = importdata('sim_data/simdata_erlang_tri.txt');

wcrit = 5e-4;

figure(1)

% Specifications
lw = 1.2; % line width
nudgeup = 0.01; % shift figures up to reduce vertical space
nudgedown = 0.015; % shift all figures down to space out bif plot
fs = 9; % font size for axes
fsl = 8; % font size for legend

% Set figure size
set(gcf,'Units','Centimeters')
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) 8 20],'PaperPositionMode','Auto',...
    'PaperUnits','Centimeters','PaperSize',[9 18],...
    'PaperPosition',[0.2 -1.5 8.5 20]) %[left bottom width height]


ax1 = subplot(6,1,1); % plot 1
ax2 = subplot(6,1,2); % plot 2
ax3 = subplot(6,1,3); % plot 3
ax4 = subplot(6,1,4); % plot 4
ax5 = subplot(6,1,5); % plot 5
ax6 = subplot(6,1,6); % plot 6

% Reduce vertical spacing between plots
p = get(ax2, 'pos');
p(2) = p(2) + nudgeup;
set(ax2,'pos',p);

p = get(ax3, 'pos');
p(2) = p(2)  + 2*nudgeup;
set(ax3,'pos',p);

p = get(ax4, 'pos');
p(2) = p(2)  + 3* nudgeup;
set(ax4,'pos',p);

p = get(ax5, 'pos');
p(2) = p(2)  + 4*nudgeup;
set(ax5,'pos',p);

p = get(ax6, 'pos');
p(2) = p(2)  + 5*nudgeup;
set(ax6,'pos',p);


% figure label position
labx = 0.02;
laby = 0.87;



%-------------------------
% Linear Increase Plots
%-------------------------


% chosen plot number
plot_num_lin = 8;

% time column
t = simdata_lin(:,1);



%------------------------
% plot 1 - risk function
%------------------------

subplot(ax1)

plot(t,simdata_lin(:,2),'Color','k','DisplayName','w(t)','LineWidth',lw)
axis([-inf,inf,0,7e-4])
set(gca,'xticklabel',[],'FontSize',fs,'YColor','k')

hold on
plot(t,ones(1,length(t))*wcrit,':k','DisplayName','wcrit','LineWidth',lw)

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[2.5,0,0])
ylabel('Risk')


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
plot(t,simdata_lin(:,22*plot_num_lin+2),'b','LineWidth',lw)
axis([-inf,inf,0.5,1])
set(gca,'xticklabel',[],'FontSize',fs,'YColor','b')

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[0,0,0])
ylabel('Uptake') % proportion of newborns getting vaccinated


yyaxis right
plot(t,sum(simdata_lin(:,22*plot_num_lin-18:22*plot_num_lin+1),2),'r','LineWidth',lw)
set(gca,'YColor','r')
axis([-inf,inf,0,6.2e-3])
% change ticks
ax = gca;
ax.YTick = [0,2e-3,4e-3,6e-3];
ax.YTickLabel = {'0','2','4','6'};

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[2,0,0])
ylabel('Infected')

% base
text(100,7.2e-3,'\times10^{-3}','Color','r','FontSize',fs)

% subfigure label
text(labx,laby,'b','Units','normalized','FontWeight','bold','FontSize',fs)



%------------------------
% Plot 3 - lag 1 AC
%------------------------

% set up grid
subplot(ax3)



% Import data
ac_struct = importdata('ac_data/ac_erlang_lin.txt');
ac_temp = ac_struct.data;

% Work with data up to tcrit
    tcrit = 80;
    time_indices = ac_temp(:,1);
    temp = abs(time_indices-tcrit);
    [val,idx] = min(temp);
    ac = ac_temp(1:idx,:);


% Find mean and standard deviation
num_comps = size(ac,2);
ac_mean_lin = mean(ac(:,2:num_comps),2);
ac_deviation_lin = std(ac(:,2:num_comps),0,2);

% Stop plot at t=tcrit i.e where threshold is passed
time_indices = ac(:,1);

% Find Kendall Tau of mean ac (2dp)
[corMatrix,pvals] = corr([time_indices,ac_mean_lin],'type','Kendall');
ktau_lin = round(corMatrix(1,2),2);

% plot with shaded error bars
shadedErrorBar(time_indices,ac_mean_lin,ac_deviation_lin,'k'); 


% Plot range
xlow=0; xhigh=100; ylow=0.5; yhigh=inf;
axis([xlow xhigh ylow yhigh ])

% Specifications
set(gca,'xticklabel',[],'FontSize',fs,'YColor','k')
% change ticks
ax = gca;
ax.YTick = [0.6,0.7,0.8];
ylabp = get(gca,'YLabel'); % move y label to the right
set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
ylabel('Lag-1 AC')

% Draw window arrow
xpos_arrow = [0.135,0.28];
ypos_arrow = [0.57,0.57];
xpos_text = 10;
ypos_text = 0.755; 

annotation('doublearrow',xpos_arrow,ypos_arrow,'LineWidth',0.3,...
    'Head1Width',5,'Head2Width',5,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',5,'Head2Length',5)

% Kendall tau text
ktxt = ['\tau = ',num2str(ktau_lin,'%.2f')];
text(0.8,0.14,ktxt,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')


% subfigure label
text(labx,laby,'c','Units','normalized','FontWeight','bold','FontSize',fs)



%-------------------------
% Triangular function plots
%-------------------------

% chosen plot number
plot_num_tri = 1;


%-----------------------
% Plot 4 - risk function
%-----------------------

subplot(ax4)

plot(t,simdata_tri(:,2),'Color','k','DisplayName','w(t)','LineWidth',lw)
axis([-inf,inf,0,7e-4])
set(gca,'xticklabel',[],'FontSize',fs,'YColor','k')

hold on

plot(t,ones(1,length(t))*wcrit,':k','DisplayName','wcrit','LineWidth',lw)

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[2.5,0,0])
ylabel('Risk')

% legend
% legend('show','FontSize',fsl,'Location','southeast');

% subfigure label
text(labx,laby,'d','Units','normalized','FontWeight','bold','FontSize',fs)


hold off

%-----------------------------
% Plot 5 - disease dynamics
%-----------------------------

subplot(ax5)

yyaxis left
plot(t,simdata_tri(:,22*plot_num_tri+2),'b','LineWidth',lw)
axis([-inf,inf,0.5,1])
set(gca,'xticklabel',[],'FontSize',fs,'YColor','b')

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[0,0,0])
ylabel('Uptake') % proportion of newborns getting vaccinated

yyaxis right
plot(t,sum(simdata_tri(:,22*plot_num_tri-18:22*plot_num_tri+1),2),'r','LineWidth',lw)
set(gca,'YColor','r')
axis([-inf,inf,0,4e-3])
% change ticks
ax = gca;
ax.YTick = [0,2e-3,4e-3];
ax.YTickLabel = {'0','2','4'};

% base
text(100,4.7e-3,'\times10^{-3}','Color','r','FontSize',fs)

ylabp = get(gca,'YLabel'); % move y label to the right
set(ylabp,'Position',get(ylabp,'Position')-[2,0,0])
ylabel('Infected')

% subfigure label
text(labx,laby,'e','Units','normalized','FontWeight','bold','FontSize',fs)



%-------------------------------
% Plot 6 - lag-1 AC
%-------------------------------


% set up grid
subplot(ax6)

% Import data
ac_struct = importdata('ac_data/ac_erlang_tri.txt');
ac = ac_struct.data;

% Find mean and standard deviation
num_comps = size(ac,2);
ac_mean_tri = mean(ac(:,2:num_comps),2);
ac_deviation_tri = std(ac(:,2:num_comps),0,2);

% Find Kendall Tau of mean ac before and after peak
time_indices = ac(:,1);
[max_ac,max_index] = max(ac_mean_tri);
tpeak = time_indices(max_index);

% PreTau (2dp)
[corMatrix,pvals1] = corr([time_indices(1:max_index),ac_mean_tri(1:max_index)],'type','Kendall');
ktau_tri_pre = round(corMatrix(1,2),2);


[corMatrix,pvals2] = corr([time_indices(max_index:end),ac_mean_tri(max_index:end)],'type','Kendall');
ktau_tri_post = round(corMatrix(1,2),2);

% Plot with shaded error bars
shadedErrorBar(time_indices,ac_mean_tri,ac_deviation_tri,'k'); 
hold on

% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(0.4,0.9,1000),':k','LineWidth',lw)

% Plot range
xlow=0; xhigh=100; ylow=-inf; yhigh=inf;
axis([xlow xhigh ylow yhigh ])


% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k')
% change ticks
ax = gca;
ax.YTick = [0.4 0.6 0.8];

ylabp = get(gca,'YLabel'); % move y label to the right
set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
ylabel('Lag-1 AC')
xlabel('Time (years)')

% Draw window arrow
xpos_arrow = [0.135,0.28];
ypos_arrow = [0.18,0.18];
annotation('doublearrow',xpos_arrow,ypos_arrow,'LineWidth',0.3,...
    'Head1Width',5,'Head2Width',5,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',5,'Head2Length',5)

% Kendall tau text
ktxt_pre = ['\tau = ',num2str(ktau_tri_pre,'%.2f')];
ktxt_post = ['\tau = ',num2str(ktau_tri_post,'%.2f')];
text(0.25,0.14,ktxt_pre,'Units','normalized','FontSize',fs)
text(0.78,0.14,ktxt_post,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')

% subfigure label
text(labx,laby,'f','Units','normalized','FontWeight','bold','FontSize',fs)



%-------------------
% Export figure
%-------------------

 %Export at 300 dpi 
 print('../../Research/vaccine_behaviour_16/PNAS_demetri/figures/fig2_erlang','-dpdf','-r300')



