%
% Figure 2 for submission to PNAS
%

clear
close all

% Import data files

sim_data_lin = importdata('sim_data/simdata_highkap_lin.txt');

% lag-1 ac
ac_struct = importdata('ac_data/ac_highkap_lin.txt');
ac = ac_struct.data;

% variance
sd_struct = importdata('sd_data/sd_highkap_lin.txt');
sd = sd_struct.data;
var = [sd(:,1),sd(:,2:end).^2];

% COV
cov_struct = importdata('cov_data/cov_highkap_lin.txt');
cov = cov_struct.data;




wcrit = 5e-4;

figure(1)

% Specifications
lw = 0.7; % line width for time-series
lwb= 0.8; % line width for bif diagram
dl = 1; % Dash length in plot
nudgeup = 0; % shift figures up to reduce vertical space
nudgedown = 0; % shift all figures down to space out bif plot
fs = 7; % font size for axes
fsl = 8; % font size for legend
fw = 'normal'; % font weight
fn = 'Helvetica'; % font name

% window arrow properties
arrow_h1 = 0.01;
arrow_h2 = 0.19;
arrow_v = 0.14;
arrow_lw = 0.7;
arrowhead_lw = 5;
arrowhead_l = 4;

% figure label position
labx = 0.02;
laby = 0.87;

% Set figure size
set(gcf,'Units','Centimeters')
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) 8 12],'PaperPositionMode','Auto',...
    'PaperUnits','Centimeters','PaperSize',[8 12],...
    'PaperPosition',[-0.15 0 8 12]) %[left bottom width height]


ax1 = subplot(4,1,1); % plot 1
ax2 = subplot(4,1,2); % plot 2
ax3 = subplot(4,1,3); % plot 3
ax4 = subplot(4,1,4); % plot 4


% Reduce vertical spacing between plots
p = get(ax2, 'pos');
p(2) = p(2) - 0.02;
set(ax2,'pos',p);

p = get(ax3, 'pos');
p(2) = p(2) -nudgedown + nudgeup-0.003;
set(ax3,'pos',p);

p = get(ax4, 'pos');
p(2) = p(2) -nudgedown + 2* nudgeup+0.015;
set(ax4,'pos',p);






%------------------------------------------------------------
% plot 1 - bifurcation diagram
%------------------------------------------------------------

% Properties
dw = 1e-6;      % Resolution
w_fin = (25/4)*10^(-4);   % Omega range

% Fixed parameter values for Measles - time unit years
u=1/50;                 % Birth - Death rate
R0=16;                  % R0 value
g=365/13;               % Recovery rate
b=R0*(g+u);             % Transmission rate

% Social parameters
d = 5e-4;

% Intersection points on bif plot
w_int1 = d;
w_int2 = d*(1-2/R0);
w_int3 = (u/b)*(R0-1) - d;

% Construct e1
w1f = 0:dw:w_int1;
w1s = w_int1:dw:w_fin;
e1f = w1f.^0;
e1s = w1s.^0;

% Construct e3
w3 = 0:dw:w_int1;
e3 = (1/2)*(1+w3/d);

% Construct e4
w4f = 0:dw:w_int3;
w4s = w_int3:dw:w_fin;
e4f = 0*w4f.^0;
e4s = 0*w4s.^0;

% Construct e5
w5 = w_int3:dw:w_int2;
e5 = (u*(1-1/R0) - (d+w5)*(u+g))/(u-2*d*(u+g));


% -------Make Plot-------------

subplot(ax1)
hold on

% Axes properties
axis([0,w_fin,0,1])
set(gca,'FontSize', fs, 'FontName',fn,'FontWeight',fw)
ylabp = get(gca,'YLabel'); % move y label
set(ylabp,'Position',get(ylabp,'Position')+[0.1e-4,0,0])
xlabp = get(gca,'XLabel'); % move x label
set(xlabp,'Position',get(xlabp,'Position')+[3.6e-4,0.29,0])
% ylabel('Uptake')
% xlabel('w\times10^{-4}')
ax = gca;
ax.XTick = [0,1e-4,2e-4,3e-4,4e-4,5e-4];
ax.XTickLabel = {'0','1','2','3','4','5'};


% plot e1
plot(w1f,e1f,'Color','k','DisplayName','e1','LineWidth',lwb)
dashline(w1s,e1s,dl,dl,dl,dl,'Color','k','LineWidth',lwb)

% plot e3
dashline(w3,e3,dl,dl,dl,dl,'Color','k','DisplayName','e3','LineWidth',lwb)

% plot e4
dashline(w4f,e4f,dl,dl,dl,dl,'Color','k','DisplayName','e4','LineWidth',lwb)
plot(w4s,e4s,'-','Color','k','LineWidth',lwb)

% plot e5
dashline(w5,e5,dl,dl,dl,dl,'--','Color','k','LineWidth',lwb)


% subfigure label
text(labx,laby,'a','Units','normalized','FontWeight','bold','FontSize', fs, 'FontName', fn)

hold off




% chosen plot number
plot_num_lin = 34;

% time column
t = sim_data_lin(:,1);



%------------------------
% plot 2 - risk function
%------------------------

subplot(ax2)

plot(t,sim_data_lin(:,2),'Color','k','DisplayName','w(t)','LineWidth',lw)
axis([-inf,inf,0,7e-4])
set(gca,'xticklabel',[],'FontSize', fs, 'FontName', fn,'FontWeight',fw,'YColor','k')

% hold on
% plot(t,ones(1,length(t))*wcrit,':k','DisplayName','wcrit','LineWidth',lw)

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[2.5,0,0])
% ylabel('Relative risk')


% legend
% legend('show','FontSize', fs, 'FontName',fnl,'Location','southeast');

% subfigure label
text(labx,laby,'b','Units','normalized','FontWeight','bold','FontSize', fs, 'FontName',fn)


hold off

%-----------------------------
% plot 3 - disease dynamics
%-----------------------------

subplot(ax3)

yyaxis left
plot(t,sim_data_lin(:,3*plot_num_lin+2),'k','LineWidth',lw)
axis([-inf,inf,0.5,1])
set(gca,'xticklabel',[],'FontSize', fs, 'FontName',fn,'YColor','k','FontWeight',fw)

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')+[1,0,0])
% ylabel('Uptake') % proportion of newborns getting vaccinated


yyaxis right
plot(t,sim_data_lin(:,3*plot_num_lin+1),'r','LineWidth',lw)
set(gca,'YColor','r')
axis([-inf,inf,0,6.2e-3])
% change ticks
ax = gca;
ax.YTick = [0,2e-3,4e-3,6e-3];
ax.YTickLabel = {'0','2','4','6'};

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')+[0.01,0,0])
% ylabel('Infected')

% base
text(90,6.8e-3,'\times10^{-3}','Color','r','FontSize', fs, 'FontName',fn,'FontWeight',fw)

% subfigure label
text(labx,laby,'c','Units','normalized','FontWeight','bold','FontSize', fs, 'FontName',fn)



%------------------------
% Plot 4 - Mean of Indicators
%------------------------

% set up grid
subplot(ax4)

% Draw window arrow
% annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
%     'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
%     'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)


% Work with data up to tcrit
    tcrit = 80;
    time_indices = ac(:,1);
    temp = abs(time_indices-tcrit);
    [val,idx] = min(temp);
    ac = ac(1:idx,:);
    var = var(1:idx,:);
    cov = cov(1:idx,:);
    


% Find mean of indicators
num_comps = size(ac,2);
ac_mean_lin = mean(ac(:,2:num_comps),2);
var_mean_lin = mean(var(:,2:num_comps),2);
cov_mean_lin = mean(cov(:,2:num_comps),2);

% plot indicators 

time_indices = ac(:,1);

yyaxis right
plot(time_indices,ac_mean_lin,'b','LineWidth',lw*1)
axis([0 100 0.6 0.82])
set(gca,'FontSize', fs, 'FontName',fn,'YColor','k','FontWeight',fw)

% change ticks
ax = gca;
ax.YTick = [6e-1 7e-1 8e-1];
ax.YTickLabel = {'0.6' '0.7' '0.8'};


% base
% text(90,8e-3,'\times10^{-3}','Color','k','FontSize', fs, 'FontName',fn)



ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')+[0,0,0])
% ylabel('Lag-1 AC') % proportion of newborns getting vaccinated
% xlabel('Time')


yyaxis left
plot(time_indices,var_mean_lin,'k','LineWidth',lw)
hold on
plot(time_indices,cov_mean_lin*10^-2,'r','LineWidth',lw)
set(gca,'YColor','k')
axis([0 100 3e-5 8e-5])
% % change ticks
% ax = gca;
% ax.YTick = [0,2e-3,4e-3,6e-3];
% ax.YTickLabel = {'0','2','4','6'};



% Specifications
set(gca,'FontSize', fs, 'FontName',fn,'FontWeight',fw)
% change ticks
ax = gca;
% ax.YTick = [0.5 0.6,0.7,0.8];
ylabp = get(gca,'YLabel'); % move y label to the right
set(ylabp,'Position',get(ylabp,'Position')+[-2.5,0,0])
% ylabel('Variance & C.V. (x10^{ -2})')





% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')


% subfigure label
text(labx,laby,'d','Units','normalized','FontWeight','bold','FontSize', fs, 'FontName',fn)







%-------------------
% Export figure
%-------------------

 %Export at 300 dpi 
 print('../../../Research/vaccine_behaviour_16/PNAS_demetri/figures/fig2_sub','-dpdf','-r300')



