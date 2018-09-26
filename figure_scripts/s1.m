
%---------------------------------------------------------------------------
% Script to plot s1 of demetri's paper
% 3x2 grid showing sensitivity of indicatros to parameters
%------------------------------------------------------------------------



clear
close all


% Specifications
lw = 1.2; % line width of mean/error bars
lw2 = 0.1; % line width of random realisations
nudgeup = 0.03; % shift figures up to reduce vertical space
nudgeleft = 0.04; % shift figures left to reduce horizontal space
fs = 9; % font size for axes
fsl = 9; % font size for label

ktau_h1 = 0.25; % position of kendall tau texts
ktau_h2 = 0.8;
ktau_v = 0.085;

tth = 0.1; % title height (as a fraction of y axis)
ttfs = 11; % title font size

% window arrow properties
arrow_h1 = 0.01;
arrow_h2 = 0.19;
arrow_v = 0.14;
arrow_lw = 0.7;
arrowhead_lw = 5;
arrowhead_l = 4;

% Set figure size (cm)
dim_horiz = 20; %landscape of letterpaper
dim_vert = 15;

% figure label position
labx = 0.03;
laby = 0.9;



% Set up figure
figure(1)

set(gcf,'Units','Centimeters')
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) dim_horiz dim_vert],'PaperPositionMode','Auto',...
    'PaperUnits','Centimeters','PaperSize',[dim_horiz-2 dim_vert-1],...
    'PaperPosition',[-1 -1 dim_horiz dim_vert]) %[left bottom width height]


% Introduce grid

ax=zeros(1,6);
for j=1:6
    ax(j) = subplot(3,2,j);
end

labels = ['a','b','c','d','e','f'];


% Grid spacing options
p = get(ax(2), 'pos');
p(1) = p(1) - nudgeleft;
set(ax(2),'pos',p);

p = get(ax(3), 'pos');
p(2) = p(2) + nudgeup;
set(ax(3),'pos',p);

p = get(ax(4), 'pos');
p(1) = p(1) - nudgeleft;
p(2) = p(2) + nudgeup;
set(ax(4),'pos',p);

p = get(ax(5), 'pos');
p(2) = p(2) + 2*nudgeup;
set(ax(5),'pos',p);

p = get(ax(6), 'pos');
p(1) = p(1) - nudgeleft;
p(2) = p(2) + 2*nudgeup;
set(ax(6),'pos',p);




%------------------------



% Import the data
ac_struct = importdata('ac_data/ac_sensi_tri.txt');
ac_tri = ac_struct.data;

ac_struct = importdata('ac_data/ac_sensi_lin.txt');
ac_temp = ac_struct.data;

sd_struct = importdata('sd_data/sd_sensi_tri.txt');
sd_tri = sd_struct.data;
var_tri = [sd_tri(:,1),sd_tri(:,2:end).^2];

sd_struct = importdata('sd_data/sd_sensi_lin.txt');
sd_temp = sd_struct.data;
var_temp = [sd_temp(:,1),sd_temp(:,2:end).^2];


cov_struct = importdata('cov_data/cov_sensi_tri.txt');
cov_tri = cov_struct.data;

cov_struct = importdata('cov_data/cov_sensi_lin.txt');
cov_temp = cov_struct.data;

% Work with data up to tcrit in case of linear increasing risk
tcrit = 80;
temp = abs(ac_temp(:,1)-tcrit);
[min_temp,idx] = min(temp);
ac_lin = ac_temp(1:idx,:);
var_lin = var_temp(1:idx,:);
cov_lin = cov_temp(1:idx,:);


%% 


%------------------------
% Column 1 - Linear increasing risk
%-------------------------




%--------------Variance-------------------%

% Find mean and standard deviation
num_comps = size(var_lin,2);
var_mean_lin = mean(var_lin(:,2:num_comps),2);
var_deviation_lin = std(var_lin(:,2:num_comps),0,2);

time_indices = var_lin(:,1);

% Find Kendall Tau of mean ac (3dp)
corMatrix = corr([time_indices,var_mean_lin],'type','Kendall');
ktau = round(corMatrix(1,2),3);

% Plot data
subplot(ax(1))


% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)


% plot with shaded error bars
shadedErrorBar(time_indices,var_mean_lin,var_deviation_lin,'k'); 

% Plot range
xlow=0; xhigh=100; ylow=0; yhigh=1e-4;
axis([xlow xhigh ylow yhigh ])

% Specifications
set(gca,'FontSize',fs,'YColor','k','xticklabel',[])
% change ticks
ax1 = gca;
% ax1.YTick = [0.6,0.7,0.8];
% ylabp = get(gca,'YLabel'); % move y label to the right
% set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
ylabel('Variance')


% Kendall tau text
ktxt = ['\tau = ',num2str(ktau,'%.2f')];
text(ktau_h2,ktau_v,ktxt,'FontSize',fs,'Units','normalized')

% title and position
tiHan = title('Linear Risk','FontSize',ttfs);
tiPos = get(tiHan,'Position');
xyrange = axis;
set(tiHan, 'position', tiPos + [0 tth * (xyrange(4) - xyrange(3)) 0]); % move title up
set(tiHan, 'units', 'inches'); % so Title doesn't move on zoom.


% subfigure label
text(labx,laby,labels(1),'Units','normalized','FontWeight','bold','FontSize',fsl)






%--------------Lag-1 AC-------------------%

% Find mean and standard deviation
num_comps = size(ac_lin,2);
ac_mean_lin = mean(ac_lin(:,2:num_comps),2);
ac_deviation_lin = std(ac_lin(:,2:num_comps),0,2);

time_indices = ac_lin(:,1);

% Find Kendall Tau of mean ac (3dp)
corMatrix = corr([time_indices,ac_mean_lin],'type','Kendall');
ktau = round(corMatrix(1,2),3);

% Plot data
subplot(ax(3))

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)


% plot with shaded error bars
shadedErrorBar(time_indices,ac_mean_lin,ac_deviation_lin,'k'); 

% Plot range
xlow=0; xhigh=100; ylow=0.5; yhigh=1;
axis([xlow xhigh ylow yhigh ])

% Specifications
set(gca,'FontSize',fs,'YColor','k','xticklabel',[])
% change ticks
ax1 = gca;
% ax1.YTick = [0.6,0.7,0.8];
% ylabp = get(gca,'YLabel'); % move y label to the right
% set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
ylabel('Lag-1 AC')


% Kendall tau text
ktxt = ['\tau = ',num2str(ktau,'%.2f')];
text(ktau_h2,ktau_v,ktxt,'FontSize',fs,'Units','normalized')

% subfigure label
text(labx,laby,labels(3),'Units','normalized','FontWeight','bold','FontSize',fsl)


%--------------C.V.-------------------%

% Find mean and standard deviation
num_comps = size(cov_lin,2);
cov_mean_lin = mean(cov_lin(:,2:num_comps),2);
cov_deviation_lin = std(cov_lin(:,2:num_comps),0,2);

time_indices = cov_lin(:,1);

% Find Kendall Tau of mean ac (3dp)
corMatrix = corr([time_indices,cov_mean_lin],'type','Kendall');
ktau = round(corMatrix(1,2),3);

% Plot data
subplot(ax(5))

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)


% plot with shaded error bars
shadedErrorBar(time_indices,cov_mean_lin,cov_deviation_lin,'k'); 

% Plot range
xlow=0; xhigh=100; ylow=-inf; yhigh=inf;
axis([xlow xhigh ylow yhigh ])

% Specifications
set(gca,'FontSize',fs,'YColor','k')
% change ticks
ax1 = gca;
% ax1.YTick = [0.6,0.7,0.8];
% ylabp = get(gca,'YLabel'); % move y label to the right
% set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
ylabel('C.V.')
xlabel('Time')


% Kendall tau text
ktxt = ['\tau = ',num2str(ktau,'%.2f')];
text(ktau_h2,ktau_v,ktxt,'FontSize',fs,'Units','normalized')

% subfigure label
text(labx,laby,labels(5),'Units','normalized','FontWeight','bold','FontSize',fsl)



%% 



%--------------------------------
% Column 2 : Triangular risk plots
%----------------------------------




%-----------------Variance------------

% grid location
subplot(ax(2))

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)


% Find mean and standard deviation
num_comps = size(var_tri,2);
var_mean_tri = mean(var_tri(:,2:num_comps),2);
var_deviation_tri = std(var_tri(:,2:num_comps),0,2);

% Find Kendall Tau of mean ac before and after peak
time_indices = var_tri(:,1);
[max_var,max_index] = max(var_mean_tri);
tpeak = time_indices(max_index);

% PreTau (2dp)
[corMatrix,pvals1] = corr([time_indices(1:max_index),var_mean_tri(1:max_index)],'type','Kendall');
ktau_tri_pre = round(corMatrix(1,2),2);


[corMatrix,pvals2] = corr([time_indices(max_index:end),var_mean_tri(max_index:end)],'type','Kendall');
ktau_tri_post = round(corMatrix(1,2),2);

% Plot with shaded error bars
shadedErrorBar(time_indices,var_mean_tri,var_deviation_tri,'k'); 
hold on

% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(0,1e-4,1000),':k','LineWidth',lw)


% Plot range
xlow=0; xhigh=100; ylow=0; yhigh=1e-4;
axis([xlow xhigh ylow yhigh ])


% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k','xticklabel',[])
% % change ticks
% ax = gca;
% ax.YTick = [0.4 0.5 0.6,0.7,0.8];
% 
% ylabp = get(gca,'YLabel'); % move y label to the right
% set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
% ylabel('Variance')


% title and position
tiHan = title('Triangular Risk','FontSize',ttfs);
tiPos = get(tiHan,'Position');
xyrange = axis;
set(tiHan, 'position', tiPos + [0 tth * (xyrange(4) - xyrange(3)) 0]); % move title up
set(tiHan, 'units', 'inches'); % so Title doesn't move on zoom.



% Kendall tau text
ktxt_pre = ['\tau = ',num2str(ktau_tri_pre,'%.2f')];
ktxt_post = ['\tau = ',num2str(ktau_tri_post,'%.2f')];
text(ktau_h1,ktau_v,ktxt_pre,'Units','normalized','FontSize',fs)
text(ktau_h2,ktau_v,ktxt_post,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')

% subfigure label
text(labx,laby,labels(2),'Units','normalized','FontWeight','bold','FontSize',fsl)






%-----------------Lag-1 AC------------

% grid location
subplot(ax(4))

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)


% Find mean and standard deviation
num_comps = size(ac_tri,2);
ac_mean_tri = mean(ac_tri(:,2:num_comps),2);
ac_deviation_tri = std(ac_tri(:,2:num_comps),0,2);

% Find Kendall Tau of mean ac before and after peak
time_indices = ac_tri(:,1);
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
plot(tpeak*ones(1,1000),linspace(0,1,1000),':k','LineWidth',lw)


% Plot range
xlow=0; xhigh=100; ylow=0.4; yhigh=1;
axis([xlow xhigh ylow yhigh ])


% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k','xticklabel',[])
% % change ticks
% ax = gca;
% ax.YTick = [0.4 0.5 0.6,0.7,0.8];
% 
% ylabp = get(gca,'YLabel'); % move y label to the right
% set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
% ylabel('Variance')




% Kendall tau text
ktxt_pre = ['\tau = ',num2str(ktau_tri_pre,'%.2f')];
ktxt_post = ['\tau = ',num2str(ktau_tri_post,'%.2f')];
text(ktau_h1,ktau_v,ktxt_pre,'Units','normalized','FontSize',fs)
text(ktau_h2,ktau_v,ktxt_post,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')

% subfigure label
text(labx,laby,labels(4),'Units','normalized','FontWeight','bold','FontSize',fsl)





%-----------------C.V------------

% grid location
subplot(ax(6))

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)


% Find mean and standard deviation
num_comps = size(cov_tri,2);
cov_mean_tri = mean(cov_tri(:,2:num_comps),2);
cov_deviation_tri = std(cov_tri(:,2:num_comps),0,2);

% Find Kendall Tau of mean ac before and after peak
time_indices = cov_tri(:,1);
[max_cov,max_index] = max(cov_mean_tri);
tpeak = time_indices(max_index);

% PreTau (2dp)
[corMatrix,pvals1] = corr([time_indices(1:max_index),cov_mean_tri(1:max_index)],'type','Kendall');
ktau_tri_pre = round(corMatrix(1,2),2);


[corMatrix,pvals2] = corr([time_indices(max_index:end),cov_mean_tri(max_index:end)],'type','Kendall');
ktau_tri_post = round(corMatrix(1,2),2);

% Plot with shaded error bars
shadedErrorBar(time_indices,cov_mean_tri,cov_deviation_tri,'k'); 
hold on

% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(0,0.1,1000),':k','LineWidth',lw)


% Plot range
xlow=0; xhigh=100; ylow=0.003; yhigh=0.01;
axis([xlow xhigh ylow yhigh ])


% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k')
% % change ticks
% ax = gca;
% ax.YTick = [0.4 0.5 0.6,0.7,0.8];
% 
% ylabp = get(gca,'YLabel'); % move y label to the right
% set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
% ylabel('Variance')
xlabel('Time')







% Kendall tau text
ktxt_pre = ['\tau = ',num2str(ktau_tri_pre,'%.2f')];
ktxt_post = ['\tau = ',num2str(ktau_tri_post,'%.2f')];
text(ktau_h1,ktau_v,ktxt_pre,'Units','normalized','FontSize',fs)
text(ktau_h2,ktau_v,ktxt_post,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')

% subfigure label
text(labx,laby,labels(6),'Units','normalized','FontWeight','bold','FontSize',fsl)










%-------------------
% Export figure
%-------------------

% Export at 300 dpi 
print('../../Research/vaccine_behaviour_16/PNAS_demetri/figures/s1','-dpdf','-r300')


