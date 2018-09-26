% Supplementary figure with 3 indicators comparing baseline and
% erlang-seasonal model

clear
close all

% Import data files

%--------For x---------------

% lag-1 ac
ac_struct = importdata('ac_data/ac_highkap_tri.txt');
ac = ac_struct.data;

ac_erlang_struct = importdata('ac_data/ac_erlangseasonal_highkap_tri.txt');
ac_erlang = ac_erlang_struct.data;

% variance
sd_struct = importdata('sd_data/sd_highkap_tri.txt');
sd = sd_struct.data;
var = [sd(:,1),sd(:,2:end).^2];

sd_struct = importdata('sd_data/sd_erlangseasonal_highkap_tri.txt');
sd = sd_struct.data;
var_erlang = [sd(:,1),sd(:,2:end).^2];

% COV
cov_struct = importdata('cov_data/cov_highkap_tri.txt');
cov = cov_struct.data;

cov_struct = importdata('cov_data/cov_erlangseasonal_highkap_tri.txt');
cov_erlang = cov_struct.data;


% ------- For 1-x----------

% lag-1 ac
ac1mx_struct = importdata('ac_data/ac_highkap_tri_1mx.txt');
ac1mx = ac1mx_struct.data;

ac1mx_struct = importdata('ac_data/ac_erlangseasonal_highkap_tri_1mx.txt');
ac1mx_erlang = ac1mx_struct.data;

% variance
sd1mx_struct = importdata('sd_data/sd_highkap_tri_1mx.txt');
sd1mx = sd1mx_struct.data;
var1mx = [sd1mx(:,1),sd1mx(:,2:end).^2];

sd1mx_struct = importdata('sd_data/sd_erlangseasonal_highkap_tri_1mx.txt');
sd1mx = sd1mx_struct.data;
var1mx_erlang = [sd1mx(:,1),sd1mx(:,2:end).^2];

% COV
cov1mx_struct = importdata('cov_data/cov_highkap_tri_1mx.txt');
cov1mx = cov1mx_struct.data;

cov1mx_struct = importdata('cov_data/cov_erlangseasonal_highkap_tri_1mx.txt');
cov1mx_erlang = cov1mx_struct.data;




wcrit = 5e-4;

figure(1)

% Specifications
lw = 1.2; % line width of mean/error bars
lw2 = 0.1; % line width of random realisations
nudgeup = 0.03; % shift figures up to reduce vertical space
nudgeleft = 0.01; % shift figures left to reduce horizontal space
fs = 9; % font size for axes
fsl = 8; % font size for legend

ktau_h1 = 0.25; % position of kendall tau texts
ktau_h2 = 0.7;
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


% figure label position
labx = 0.04;
laby = 0.9;

% seed numbers for set of random realisations
seed1 = 300;
seed2 = 1;

% Set figure size (cm)
dim_horiz = 27.94; %landscape of letterpaper
dim_vert = 18;

set(gcf,'Units','Centimeters')
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) dim_horiz dim_vert],'PaperPositionMode','Auto',...
    'PaperUnits','Centimeters','PaperSize',[dim_horiz-4 dim_vert-1],...
    'PaperPosition',[-2 -1 dim_horiz dim_vert]) %[left bottom width height]


ax1 = subplot(3,4,1);
ax2 = subplot(3,4,2);
ax3 = subplot(3,4,3);
ax4 = subplot(3,4,4);
ax5 = subplot(3,4,5);
ax6 = subplot(3,4,6);
ax7 = subplot(3,4,7);
ax8 = subplot(3,4,8);
ax9 = subplot(3,4,9);
ax10 = subplot(3,4,10);
ax11 = subplot(3,4,11);
ax12 = subplot(3,4,12);



% Grid spacing options
p = get(ax2, 'pos');
p(1) = p(1) - nudgeleft;
set(ax2,'pos',p);

p = get(ax3, 'pos');
p(1) = p(1) - 2*nudgeleft;
set(ax3,'pos',p);

p = get(ax4, 'pos');
p(1) = p(1) - 3*nudgeleft;
set(ax4,'pos',p);

p = get(ax5, 'pos');
p(2) = p(2) + nudgeup;
set(ax5,'pos',p);

p = get(ax6, 'pos');
p(1) = p(1) - nudgeleft;
p(2) = p(2) + nudgeup;
set(ax6,'pos',p);

p = get(ax7, 'pos');
p(1) = p(1) - 2*nudgeleft;
p(2) = p(2) + nudgeup;
set(ax7,'pos',p);

p = get(ax8, 'pos');
p(1) = p(1) - 3*nudgeleft;
p(2) = p(2) + nudgeup;
set(ax8,'pos',p);

p = get(ax9, 'pos');
p(2) = p(2) + 2*nudgeup;
set(ax9,'pos',p);

p = get(ax10, 'pos');
p(1) = p(1) - nudgeleft;
p(2) = p(2) + 2*nudgeup;
set(ax10,'pos',p);

p = get(ax11, 'pos');
p(1) = p(1) - 2*nudgeleft;
p(2) = p(2) + 2*nudgeup;
set(ax11,'pos',p);

p = get(ax12, 'pos');
p(1) = p(1) - 3*nudgeleft;
p(2) = p(2) + 2*nudgeup;
set(ax12,'pos',p);




%% Column 1 : Baseline model for x


%-------------Collection of 10 random realisations-------------%

num_comps=size(ac,2)-1;
% select 10 random numbers between 2 and num_comps
rng(seed1)
rand_set=ceil(rand(10,1)*(num_comps-1)+1);

ac_set=ac(:,rand_set);
var_set=var(:,rand_set);
cov_set=cov(:,rand_set);

ac1mx_set=ac1mx(:,rand_set);
var1mx_set=var1mx(:,rand_set);
cov1mx_set=cov1mx(:,rand_set);


%-----------------Variance------------

% grid location
subplot(ax1)

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)


% Find mean and standard deviation
num_comps = size(var,2);
var_mean_tri = mean(var(:,2:num_comps),2);
var_deviation_tri = std(var(:,2:num_comps),0,2);

% Find Kendall Tau of mean ac before and after peak
time_indices = var(:,1);
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

% Plot set of random realisations
plot(time_indices,var_set,'LineWidth',lw2)


% Plot range
xlow=0; xhigh=100; ylow=0; yhigh=0.8e-4;
axis([xlow xhigh ylow yhigh ])


% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k','xticklabel',[])
% % change ticks
% ax = gca;
% ax.YTick = [0.4 0.5 0.6,0.7,0.8];
% 
% ylabp = get(gca,'YLabel'); % move y label to the right
% set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
ylabel('Variance')


% title and position
tiHan = title('Baseline Model x','FontSize',ttfs);
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
text(labx,laby,'a','Units','normalized','FontWeight','bold','FontSize',fs)


%------------------------lag-1 AC-------------

% set up grid
subplot(ax5)

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)

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



% Plot set of random realisations
plot(time_indices,ac_set,'LineWidth',lw2)


% Plot range
xlow=0; xhigh=100; ylow=0.1; yhigh=0.9;
axis([xlow xhigh ylow yhigh ])


% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(ylow,yhigh,1000),':k','LineWidth',lw)

% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k','xticklabel',[])
% % change ticks
% ax = gca;
% ax.YTick = [0.4 0.5 0.6,0.7,0.8];

ylabp = get(gca,'YLabel'); % move y label to the right
set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
ylabel('Lag-1 AC')


% Kendall tau text
ktxt_pre = ['\tau = ',num2str(ktau_tri_pre,'%.2f')];
ktxt_post = ['\tau = ',num2str(ktau_tri_post,'%.2f')];
text(ktau_h1,ktau_v,ktxt_pre,'Units','normalized','FontSize',fs)
text(ktau_h2,ktau_v,ktxt_post,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')

% subfigure label
text(labx,laby,'e','Units','normalized','FontWeight','bold','FontSize',fs)




%------------- COV--------------%


% set up grid
subplot(ax9)

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)

% Find mean and standard deviation
num_comps = size(cov,2);
cov_mean_tri = mean(cov(:,2:num_comps),2);
cov_deviation_tri = std(cov(:,2:num_comps),0,2);

% Find Kendall Tau of mean cov before and after peak
time_indices = cov(:,1);
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
plot(tpeak*ones(1,1000),linspace(0,0.01,1000),':k','LineWidth',lw)

% Plot set of random realisations
plot(time_indices,cov_set,'LineWidth',lw2)

hold off 

% Plot range
xlow=0; xhigh=100; ylow=0.002; yhigh=inf;
axis([xlow xhigh ylow yhigh ])


% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k')
% change ticks
% ax = gca;
% ax.YTick = [4e-3 8e-3 12e-3 16e-3];
% ax.YTickLabel = [4  8 12 16];

% % base
% text(-0.1,20e-3,'\times10^{-3}','Color','k','FontSize',fs)




ylabp = get(gca,'YLabel'); % move y label to the right
set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
ylabel('C.V.')
xlabel('Time')


% Kendall tau text
ktxt_pre = ['\tau = ',num2str(ktau_tri_pre,'%.2f')];
ktxt_post = ['\tau = ',num2str(ktau_tri_post,'%.2f')];
text(ktau_h1,ktau_v,ktxt_pre,'Units','normalized','FontSize',fs)
text(ktau_h2,ktau_v,ktxt_post,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')

% subfigure label
text(labx,laby,'i','Units','normalized','FontWeight','bold','FontSize',fs)



%% Column 3 : Baseline model for 1-x


%-----------------Variance------------

% grid location
subplot(ax3)

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)

% Find mean and standard deviation
num_comps = size(var1mx,2);
var1mx_mean_tri = mean(var1mx(:,2:num_comps),2);
var1mx_deviation_tri = std(var1mx(:,2:num_comps),0,2);

% Find Kendall Tau of mean ac before and after peak
time_indices = var1mx(:,1);
[max_var1mx,max_index] = max(var1mx_mean_tri);
tpeak = time_indices(max_index);

% PreTau (2dp)
[corMatrix,pvals1] = corr([time_indices(1:max_index),var1mx_mean_tri(1:max_index)],'type','Kendall');
ktau_tri_pre = round(corMatrix(1,2),2);


[corMatrix,pvals2] = corr([time_indices(max_index:end),var1mx_mean_tri(max_index:end)],'type','Kendall');
ktau_tri_post = round(corMatrix(1,2),2);

% Plot with shaded error bars
shadedErrorBar(time_indices,var1mx_mean_tri,var1mx_deviation_tri,'k'); 
hold on

% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(0,1e-4,1000),':k','LineWidth',lw)

% Plot set of random realisations
plot(time_indices,var1mx_set,'LineWidth',lw2)


% Plot range
xlow=0; xhigh=100; ylow=0; yhigh=8e-5;
axis([xlow xhigh ylow yhigh ])


% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k','xticklabel',[])
% % change ticks
% ax = gca;
% ax.YTick = [0.4 0.5 0.6,0.7,0.8];
% 
% ylabp = get(gca,'YLabel'); % move y label to the right
% set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])

% title and position
tiHan = title('Baseline Model 1-x','FontSize',ttfs);
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
text(labx,laby,'c','Units','normalized','FontWeight','bold','FontSize',fs)


%------------------------lag-1 AC-------------

% set up grid
subplot(ax7)

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)

% Find mean and standard deviation
num_comps = size(ac1mx,2);
ac1mx_mean_tri = mean(ac1mx(:,2:num_comps),2);
ac1mx_deviation_tri = std(ac1mx(:,2:num_comps),0,2);

% Find Kendall Tau of mean ac1mx before and after peak
time_indices = ac1mx(:,1);
[max_ac1mx,max_index] = max(ac1mx_mean_tri);
tpeak = time_indices(max_index);

% PreTau (2dp)
[corMatrix,pvals1] = corr([time_indices(1:max_index),ac1mx_mean_tri(1:max_index)],'type','Kendall');
ktau_tri_pre = round(corMatrix(1,2),2);


[corMatrix,pvals2] = corr([time_indices(max_index:end),ac1mx_mean_tri(max_index:end)],'type','Kendall');
ktau_tri_post = round(corMatrix(1,2),2);

% Plot with shaded error bars
shadedErrorBar(time_indices,ac1mx_mean_tri,ac1mx_deviation_tri,'k'); 
hold on



% Plot set of random realisations
plot(time_indices,ac1mx_set,'LineWidth',lw2)


% Plot range
xlow=0; xhigh=100; ylow=0.1; yhigh=0.9;
axis([xlow xhigh ylow yhigh ])

% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(ylow,yhigh,1000),':k','LineWidth',lw)


% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k','xticklabel',[])
% % change ticks
% ax = gca;
% ax.YTick = [0.4 0.5 0.6,0.7,0.8];

ylabp = get(gca,'YLabel'); % move y label to the right
set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])


% Kendall tau text
ktxt_pre = ['\tau = ',num2str(ktau_tri_pre,'%.2f')];
ktxt_post = ['\tau = ',num2str(ktau_tri_post,'%.2f')];
text(ktau_h1,ktau_v,ktxt_pre,'Units','normalized','FontSize',fs)
text(ktau_h2,ktau_v,ktxt_post,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')

% subfigure label
text(labx,laby,'g','Units','normalized','FontWeight','bold','FontSize',fs)




%------------- cov1mx--------------%


% set up grid
subplot(ax11)

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)

% Find mean and standard deviation
num_comps = size(cov1mx,2);
cov1mx_mean_tri = mean(cov1mx(:,2:num_comps),2);
cov1mx_deviation_tri = std(cov1mx(:,2:num_comps),0,2);

% Find Kendall Tau of mean cov1mx before and after min
time_indices = cov1mx(:,1);
[min_cov1mx,max_index] = min(cov1mx_mean_tri);
tpeak = time_indices(max_index);

% PreTau (2dp)
[corMatrix,pvals1] = corr([time_indices(1:max_index),cov1mx_mean_tri(1:max_index)],'type','Kendall');
ktau_tri_pre = round(corMatrix(1,2),2);


[corMatrix,pvals2] = corr([time_indices(max_index:end),cov1mx_mean_tri(max_index:end)],'type','Kendall');
ktau_tri_post = round(corMatrix(1,2),2);

% Plot with shaded error bars
shadedErrorBar(time_indices,cov1mx_mean_tri,cov1mx_deviation_tri,'k'); 
hold on


% Plot set of random realisations
plot(time_indices,cov1mx_set,'LineWidth',lw2)
 

% Plot range
xlow=0; xhigh=100; ylow=0; yhigh=1;
axis([xlow xhigh ylow yhigh ])

% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(ylow,yhigh,1000),':k','LineWidth',lw)

% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k')
% change ticks
% ax = gca;
% ax.YTick = [4e-3 8e-3 12e-3 16e-3];
% ax.YTickLabel = [4  8 12 16];

% % base
% text(-0.1,20e-3,'\times10^{-3}','Color','k','FontSize',fs)




ylabp = get(gca,'YLabel'); % move y label to the right
set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
xlabel('Time')


% Kendall tau text
ktxt_pre = ['\tau = ',num2str(ktau_tri_pre,'%.2f')];
ktxt_post = ['\tau = ',num2str(ktau_tri_post,'%.2f')];
text(ktau_h1,ktau_v,ktxt_pre,'Units','normalized','FontSize',fs)
text(ktau_h2,ktau_v,ktxt_post,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')

% subfigure label
text(labx,laby,'k','Units','normalized','FontWeight','bold','FontSize',fs)



%% Column 2 : Erlang Model for x


%-------------Collection of 10 random realisations-------------%

num_comps=size(ac_erlang,2)-1;
% select 10 random numbers between 2 and num_comps
rng(seed2)
rand_set=ceil(rand(10,1)*(num_comps-1)+1);

ac_erlang_set=ac_erlang(:,rand_set);
var_erlang_set=var_erlang(:,rand_set);
cov_erlang_set=cov_erlang(:,rand_set);

ac1mx_erlang_set=ac1mx_erlang(:,rand_set);
var1mx_erlang_set=var1mx_erlang(:,rand_set);
cov1mx_erlang_set=cov1mx_erlang(:,rand_set);


%-----------------Variance------------

% grid location
subplot(ax2)

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)

% Find mean and standard deviation
num_comps = size(var_erlang,2);
var_erlang_mean_tri = mean(var_erlang(:,2:num_comps),2);
var_erlang_deviation_tri = std(var_erlang(:,2:num_comps),0,2);

% Find Kendall Tau of mean ac before and after peak
time_indices = var_erlang(:,1);
[max_var_erlang,max_index] = max(var_erlang_mean_tri);
tpeak = time_indices(max_index);

% PreTau (2dp)
[corMatrix,pvals1] = corr([time_indices(1:max_index),var_erlang_mean_tri(1:max_index)],'type','Kendall');
ktau_tri_pre = round(corMatrix(1,2),2);


[corMatrix,pvals2] = corr([time_indices(max_index:end),var_erlang_mean_tri(max_index:end)],'type','Kendall');
ktau_tri_post = round(corMatrix(1,2),2);

% Plot with shaded error bars
shadedErrorBar(time_indices,var_erlang_mean_tri,var_erlang_deviation_tri,'k'); 
hold on

% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(0,1e-4,1000),':k','LineWidth',lw)

% Plot set of random realisations
plot(time_indices,var_erlang_set,'LineWidth',lw2)


% Plot range
xlow=0; xhigh=100; ylow=0; yhigh=0.8e-4;
axis([xlow xhigh ylow yhigh ])


% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k','xticklabel',[])
% % change ticks
% ax = gca;
% ax.YTick = [0.4 0.5 0.6,0.7,0.8];
% 
% ylabp = get(gca,'YLabel'); % move y label to the right
% set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
%ylabel('Variance')


% title and position
tiHan = title('Erlang-Seasonal x','FontSize',ttfs);
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
text(labx,laby,'b','Units','normalized','FontWeight','bold','FontSize',fs)


%------------------------lag-1 AC-------------

% set up grid
subplot(ax6)

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)


% Find mean and standard deviation
num_comps = size(ac_erlang,2);
ac_erlang_mean_tri = mean(ac_erlang(:,2:num_comps),2);
ac_erlang_deviation_tri = std(ac_erlang(:,2:num_comps),0,2);

% Find Kendall Tau of mean ac before and after peak
time_indices = ac_erlang(:,1);
[max_ac_erlang,max_index] = max(ac_erlang_mean_tri);
tpeak = time_indices(max_index);

% PreTau (2dp)
[corMatrix,pvals1] = corr([time_indices(1:max_index),ac_erlang_mean_tri(1:max_index)],'type','Kendall');
ktau_tri_pre = round(corMatrix(1,2),2);


[corMatrix,pvals2] = corr([time_indices(max_index:end),ac_erlang_mean_tri(max_index:end)],'type','Kendall');
ktau_tri_post = round(corMatrix(1,2),2);

% Plot with shaded error bars
shadedErrorBar(time_indices,ac_erlang_mean_tri,ac_erlang_deviation_tri,'k'); 
hold on



% Plot set of random realisations
plot(time_indices,ac_erlang_set,'LineWidth',lw2)


% Plot range
xlow=0; xhigh=100; ylow=0.1; yhigh=0.9;
axis([xlow xhigh ylow yhigh ])


% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(ylow,yhigh,1000),':k','LineWidth',lw)

% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k','xticklabel',[])
% % change ticks
% ax = gca;
% ax.YTick = [0.4 0.5 0.6,0.7,0.8];

% ylabp = get(gca,'YLabel'); % move y label to the right
% set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
% ylabel('Lag-1 AC')


% Kendall tau text
ktxt_pre = ['\tau = ',num2str(ktau_tri_pre,'%.2f')];
ktxt_post = ['\tau = ',num2str(ktau_tri_post,'%.2f')];
text(ktau_h1,ktau_v,ktxt_pre,'Units','normalized','FontSize',fs)
text(ktau_h2,ktau_v,ktxt_post,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')

% subfigure label
text(labx,laby,'f','Units','normalized','FontWeight','bold','FontSize',fs)




%------------- COV--------------%


% set up grid
subplot(ax10)

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)

% Find mean and standard deviation
num_comps = size(cov_erlang,2);
cov_erlang_mean_tri = mean(cov_erlang(:,2:num_comps),2);
cov_erlang_deviation_tri = std(cov_erlang(:,2:num_comps),0,2);

% Find Kendall Tau of mean cov_erlang before and after peak
time_indices = cov_erlang(:,1);
[max_cov_erlang,max_index] = max(cov_erlang_mean_tri);
tpeak = time_indices(max_index);

% PreTau (2dp)
[corMatrix,pvals1] = corr([time_indices(1:max_index),cov_erlang_mean_tri(1:max_index)],'type','Kendall');
ktau_tri_pre = round(corMatrix(1,2),2);


[corMatrix,pvals2] = corr([time_indices(max_index:end),cov_erlang_mean_tri(max_index:end)],'type','Kendall');
ktau_tri_post = round(corMatrix(1,2),2);

% Plot with shaded error bars
shadedErrorBar(time_indices,cov_erlang_mean_tri,cov_erlang_deviation_tri,'k'); 
hold on

% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(0,0.01,1000),':k','LineWidth',lw)

% Plot set of random realisations
plot(time_indices,cov_erlang_set,'LineWidth',lw2)

hold off 

% Plot range
xlow=0; xhigh=100; ylow=0.002; yhigh=inf;
axis([xlow xhigh ylow yhigh ])


% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k')
% change ticks
% ax = gca;
% ax.YTick = [4e-3 8e-3 12e-3 16e-3];
% ax.YTickLabel = [4  8 12 16];

% % base
% text(-0.1,20e-3,'\times10^{-3}','Color','k','FontSize',fs)




ylabp = get(gca,'YLabel'); % move y label to the right
set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
% ylabel('C.V.')
xlabel('Time')


% Kendall tau text
ktxt_pre = ['\tau = ',num2str(ktau_tri_pre,'%.2f')];
ktxt_post = ['\tau = ',num2str(ktau_tri_post,'%.2f')];
text(ktau_h1,ktau_v,ktxt_pre,'Units','normalized','FontSize',fs)
text(ktau_h2,ktau_v,ktxt_post,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')

% subfigure label
text(labx,laby,'j','Units','normalized','FontWeight','bold','FontSize',fs)



%% Column 4 : Erlang model for 1-x


%-----------------Variance------------

% grid location
subplot(ax4)

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)

% Find mean and standard deviation
num_comps = size(var1mx_erlang,2);
var1mx_erlang_mean_tri = mean(var1mx_erlang(:,2:num_comps),2);
var1mx_erlang_deviation_tri = std(var1mx_erlang(:,2:num_comps),0,2);

% Find Kendall Tau of mean ac before and after peak
time_indices = var1mx_erlang(:,1);
[max_var1mx_erlang,max_index] = max(var1mx_erlang_mean_tri);
tpeak = time_indices(max_index);

% PreTau (2dp)
[corMatrix,pvals1] = corr([time_indices(1:max_index),var1mx_erlang_mean_tri(1:max_index)],'type','Kendall');
ktau_tri_pre = round(corMatrix(1,2),2);


[corMatrix,pvals2] = corr([time_indices(max_index:end),var1mx_erlang_mean_tri(max_index:end)],'type','Kendall');
ktau_tri_post = round(corMatrix(1,2),2);

% Plot with shaded error bars
shadedErrorBar(time_indices,var1mx_erlang_mean_tri,var1mx_erlang_deviation_tri,'k'); 
hold on

% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(0,1e-4,1000),':k','LineWidth',lw)

% Plot set of random realisations
plot(time_indices,var1mx_erlang_set,'LineWidth',lw2)


% Plot range
xlow=0; xhigh=100; ylow=0; yhigh=8e-5;
axis([xlow xhigh ylow yhigh ])


% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k','xticklabel',[])
% % change ticks
% ax = gca;
% ax.YTick = [0.4 0.5 0.6,0.7,0.8];
% 
% ylabp = get(gca,'YLabel'); % move y label to the right
% set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])

% title and position
tiHan = title('Erlang-Seasonal 1-x','FontSize',ttfs);
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
text(labx,laby,'d','Units','normalized','FontWeight','bold','FontSize',fs)


%------------------------lag-1 AC-------------

% set up grid
subplot(ax8)

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)

% Find mean and standard deviation
num_comps = size(ac1mx_erlang,2);
ac1mx_erlang_mean_tri = mean(ac1mx_erlang(:,2:num_comps),2);
ac1mx_erlang_deviation_tri = std(ac1mx_erlang(:,2:num_comps),0,2);

% Find Kendall Tau of mean ac1mx_erlang before and after peak
time_indices = ac1mx_erlang(:,1);
[max_ac1mx_erlang,max_index] = max(ac1mx_erlang_mean_tri);
tpeak = time_indices(max_index);

% PreTau (2dp)
[corMatrix,pvals1] = corr([time_indices(1:max_index),ac1mx_erlang_mean_tri(1:max_index)],'type','Kendall');
ktau_tri_pre = round(corMatrix(1,2),2);


[corMatrix,pvals2] = corr([time_indices(max_index:end),ac1mx_erlang_mean_tri(max_index:end)],'type','Kendall');
ktau_tri_post = round(corMatrix(1,2),2);

% Plot with shaded error bars
shadedErrorBar(time_indices,ac1mx_erlang_mean_tri,ac1mx_erlang_deviation_tri,'k'); 
hold on



% Plot set of random realisations
plot(time_indices,ac1mx_erlang_set,'LineWidth',lw2)


% Plot range
xlow=0; xhigh=100; ylow=0.1; yhigh=0.9;
axis([xlow xhigh ylow yhigh ])

% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(ylow,yhigh,1000),':k','LineWidth',lw)


% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k','xticklabel',[])
% % change ticks
% ax = gca;
% ax.YTick = [0.4 0.5 0.6,0.7,0.8];

ylabp = get(gca,'YLabel'); % move y label to the right
set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])


% Kendall tau text
ktxt_pre = ['\tau = ',num2str(ktau_tri_pre,'%.2f')];
ktxt_post = ['\tau = ',num2str(ktau_tri_post,'%.2f')];
text(ktau_h1,ktau_v,ktxt_pre,'Units','normalized','FontSize',fs)
text(ktau_h2,ktau_v,ktxt_post,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')

% subfigure label
text(labx,laby,'h','Units','normalized','FontWeight','bold','FontSize',fs)




%------------- cov1mx_erlang--------------%


% set up grid
subplot(ax12)

% Draw window arrow
annotation_pinned('doublearrow',[arrow_h1,arrow_h2],[arrow_v,arrow_v],'LineWidth',arrow_lw,...
    'Head1Width',arrowhead_lw,'Head2Width',arrowhead_lw,'Head1Style','vback2','Head2Style','vback2',...
    'Head1Length',arrowhead_l,'Head2Length',arrowhead_l)

% Find mean and standard deviation
num_comps = size(cov1mx_erlang,2);
cov1mx_erlang_mean_tri = mean(cov1mx_erlang(:,2:num_comps),2);
cov1mx_erlang_deviation_tri = std(cov1mx_erlang(:,2:num_comps),0,2);

% Find Kendall Tau of mean cov1mx_erlang before and after min
time_indices = cov1mx_erlang(:,1);
[min_cov1mx_erlang,max_index] = min(cov1mx_erlang_mean_tri);
tpeak = time_indices(max_index);

% PreTau (2dp)
[corMatrix,pvals1] = corr([time_indices(1:max_index),cov1mx_erlang_mean_tri(1:max_index)],'type','Kendall');
ktau_tri_pre = round(corMatrix(1,2),2);


[corMatrix,pvals2] = corr([time_indices(max_index:end),cov1mx_erlang_mean_tri(max_index:end)],'type','Kendall');
ktau_tri_post = round(corMatrix(1,2),2);

% Plot with shaded error bars
shadedErrorBar(time_indices,cov1mx_erlang_mean_tri,cov1mx_erlang_deviation_tri,'k'); 
hold on


% Plot set of random realisations
plot(time_indices,cov1mx_erlang_set,'LineWidth',lw2)
 

% Plot range
xlow=0; xhigh=100; ylow=0; yhigh=1;
axis([xlow xhigh ylow yhigh ])

% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(ylow,yhigh,1000),':k','LineWidth',lw)

% Axes Specifications
set(gca,'FontSize',fs,'YColor','k','XColor','k')
% change ticks
% ax = gca;
% ax.YTick = [4e-3 8e-3 12e-3 16e-3];
% ax.YTickLabel = [4  8 12 16];

% % base
% text(-0.1,20e-3,'\times10^{-3}','Color','k','FontSize',fs)




ylabp = get(gca,'YLabel'); % move y label to the right
set(ylabp,'Position',get(ylabp,'Position')+[0.5,0,0])
xlabel('Time')


% Kendall tau text
ktxt_pre = ['\tau = ',num2str(ktau_tri_pre,'%.2f')];
ktxt_post = ['\tau = ',num2str(ktau_tri_post,'%.2f')];
text(ktau_h1,ktau_v,ktxt_pre,'Units','normalized','FontSize',fs)
text(ktau_h2,ktau_v,ktxt_post,'Units','normalized','FontSize',fs)

% Make sure axes are drawn on top of grahpics
set(gca,'Layer','top')

% subfigure label
text(labx,laby,'l','Units','normalized','FontWeight','bold','FontSize',fs)














%-------------------
% Export the beast
%-------------------

%Export at 300 dpi 
print('../../Research/vaccine_behaviour_16/PNAS_demetri/figures/sup_erlang','-dpdf','-r300')



