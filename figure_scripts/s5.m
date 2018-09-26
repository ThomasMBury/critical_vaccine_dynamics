
%---------------------------------------------------------------------------
% Script to plot s5 of demetri's paper
% Dynamics away from the bifurcation point
% don't show the increase or decrease in lag-1 ac/ variance
%------------------------------------------------------------------------


clear
close all


% Specifications
lw = 1.2; % line width of mean/error bars
lw2 = 0.1; % line width of random realisations
nudgeup = 0.02; % shift figures up to reduce vertical space
nudgeleft = 0.04; % shift figures left to reduce horizontal space
fs = 9; % font size for axes
fsl = 9; % font size for label

ktau_h1 = 0.25; % position of kendall tau texts
ktau_h2 = 0.82;
ktau_v = 0.085;

tth = 0.1; % title height (as a fraction of y axis)
ttfs = 11; % title font size

% window arrow properties
arrow_h1 = 0.01;
arrow_h2 = 0.24;
arrow_v = 0.14;
arrow_lw = 0.7;
arrowhead_lw = 5;
arrowhead_l = 4;

% Set figure size (cm)
dim_horiz = 10; %landscape of letterpaper
dim_vert = 15;

% figure label position
labx = 0.03;
laby = 0.88;



% Set up figure
figure(1)

set(gcf,'Units','Centimeters')
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) dim_horiz dim_vert],'PaperPositionMode','Auto',...
    'PaperUnits','Centimeters','PaperSize',[dim_horiz dim_vert-1],...
    'PaperPosition',[0 -1 dim_horiz dim_vert]) %[left bottom width height]


% Introduce grid

ax=zeros(1,4);
for j=1:4
    ax(j) = subplot(4,1,j);
end

labels = ['a','b','c','d'];


% Grid spacing options
p = get(ax(2), 'pos');
p(2) = p(2) -0.01;
set(ax(2),'pos',p);

p = get(ax(3), 'pos');
p(2) = p(2) -0.01 + nudgeup;
set(ax(3),'pos',p);

p = get(ax(4), 'pos');
p(2) = p(2) -0.01 + 2*nudgeup;
set(ax(4),'pos',p);



%-----------------------------
% Plot 1 - Uptake and Disease timeseries
%-----------------------------

% Import data

simdata_traj = importdata('simdata_trans_multiple.txt');
plot_num = 14;
t = simdata_traj(:,1);

subplot(ax(1))

% Uptake series
yyaxis left
plot(t,simdata_traj(:,3*plot_num+2),'b','LineWidth',lw)
axis([-inf,inf,0.5,1])
set(gca,'FontSize',fs,'YColor','b')
ylabel('Uptake') % proportion of newborns getting vaccinated

% Disease series
yyaxis right
plot(t,simdata_traj(:,3*plot_num+1),'r','LineWidth',lw)
set(gca,'YColor','r')
axis([-inf,inf,0,5e-3])
% change ticks
axtemp = gca;
axtemp.YTick = [1e-3,2e-3,3e-3,4e-3];
axtemp.YTickLabel = {'1','2','3','4'};
axtemp.XTick = [0 50,100,150,200,250,300];


ylabel('Infected')
xlabel('Time')

% base
text(0.95,1.15,'\times10^{-3}','Color','r','FontSize',fs,'Units','normalized')


% subfigure label
text(labx,laby,labels(1),'Units','normalized','FontWeight','bold','FontSize',fsl)





%-----------------------------------
% Plot 2 - Variance
%-------------------------------

% Import data
var_struct = importdata('sd_data/sd_trans.txt');
var = var_struct.data;

% Details
time_indices = var(:,1);
num_comps = size(var,2);

% Find mean and standard deviation
var_mean = mean(var(:,2:num_comps),2);
var_deviation = std(var(:,2:num_comps),0,2);

% Find Kendall Tau of mean var (2dp)
corMatrix = corr([time_indices,var_mean],'type','Kendall');
ktau_var = round(corMatrix(1,2),3);

% Make plot
subplot(ax(2))

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)

shadedErrorBar(time_indices,var_mean,var_deviation,'k'); 


% Specifications
set(gca,'FontSize',fs,'YColor','k','xticklabel',[])
% change ticks
ax1 = gca;
% ax1.YTick = [0.6,0.7,0.8];
ax1.XTick = [0 5 10 15 20];
% ylabp = get(gca,'YLabel'); % move y label to the right
% set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
ylabel('Variance')

% Plot range
xlow=0; xhigh=20; ylow=2e-3; yhigh=8e-3;
axis([xlow inf ylow yhigh ])


% Kendall tau text
ktxt = ['\tau = ',num2str(ktau_var,'%.2f')];
text(ktau_h2,ktau_v,ktxt,'FontSize',fs,'Units','normalized')


% subfigure label
text(labx,laby,labels(2),'Units','normalized','FontWeight','bold','FontSize',fsl)



%-----------------------------------
% Plot 3 - Lag-1 AC
%-------------------------------

% Import data
ac_struct = importdata('ac_data/ac_trans.txt');
ac = ac_struct.data;

% Details
time_indices = ac(:,1);
num_comps = size(ac,2);

% Find mean and standard deviation
ac_mean = mean(ac(:,2:num_comps),2);
ac_deviation = std(ac(:,2:num_comps),0,2);

% Find Kendall Tau of mean ac (2dp)
corMatrix = corr([time_indices,ac_mean],'type','Kendall');
ktau_ac = round(corMatrix(1,2),3);


% Make plot
subplot(ax(3))

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)

shadedErrorBar(time_indices,ac_mean,ac_deviation,'k'); 
set(gca,'FontSize',fs,'xticklabel',[])          % Font size
ylabel('Lag-1 AC')

ax1 = gca;
ax1.XTick = [0 5 10 15 20];

% Plot range
xlow=0; xhigh=inf; ylow=0.6; yhigh=1;
axis([xlow xhigh ylow yhigh ])



% Kendall tau text
ktxt = ['\tau = ',num2str(ktau_ac,'%.2f')];
text(ktau_h2,ktau_v,ktxt,'FontSize',fs,'Units','normalized')


% subfigure label
text(labx,laby,labels(3),'Units','normalized','FontWeight','bold','FontSize',fsl)




%-----------------------------------
% Plot 4 - C.V
%-------------------------------

% Import data
cov_struct = importdata('cov_data/cov_trans.txt');
cov = cov_struct.data;

% Details
time_indices = cov(:,1);
num_comps = size(cov,2);

% Find mean and standard deviation
cov_mean = mean(cov(:,2:num_comps),2);
cov_deviation = std(cov(:,2:num_comps),0,2);

% Find Kendall Tau of mean cov (2dp)
corMatrix = corr([time_indices,cov_mean],'type','Kendall');
ktau_cov = round(corMatrix(1,2),3);

% Make plot
subplot(ax(4))

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)

shadedErrorBar(time_indices,cov_mean,cov_deviation,'k'); 
set(gca,'FontSize',fs)          % Font size
xlabel('Time')
ylabel('C.V.')
% set(gca,'YTick',[])           % Change ticks if necessary
% Plot range
xlow=0; xhigh=20; ylow=2e-3; yhigh=8e-3;
axis([xlow inf ylow yhigh ])



% Kendall tau text
ktxt = ['\tau = ',num2str(ktau_cov,'%.2f')];
text(ktau_h2,ktau_v,ktxt,'FontSize',fs,'Units','normalized')


% subfigure label
text(labx,laby,labels(4),'Units','normalized','FontWeight','bold','FontSize',fsl)






%------------------------
% Export figure
%--------------------------

% Export at 300 dpi 
print('../../Research/vaccine_behaviour_16/PNAS_demetri/figures/s5','-dpdf','-r300')







