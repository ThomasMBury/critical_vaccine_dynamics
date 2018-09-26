% Script to construct S8 for Demetri's paper

% AC for pyramid risk
% Grid showing output for various rolling window sizes

clear
close all


% Import the data into a cell array (each element of the cell may have different
% dimensions!)
ac_cell = cell(1,12);
for j=1:12
    ac_struct = importdata(strcat('ac_data/ac_tri_win',num2str(j),'.txt'));
    ac_cell{j} = ac_struct.data;
    
end

% For each element of cell array, make a plot and place in grid

% Set up figure
figure(1)
% Set figure size
set(gcf,'Units','Centimeters')
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) 20 20 ],'PaperPositionMode','Auto',...
    'PaperUnits','Centimeters','PaperSize',[19 19 ])
% Font size
fs = 9;

% Introduce grid

ax=zeros(1,12);
for j=1:12
    ax(j) = subplot(4,3,j);
end

labels = ['a','b','c','d','e','f','g','h','i','j','k','l'];


% Fill in each subpanel with data plotted from each component of cell

for i=1:12
    
subplot(ax(i))
ac = ac_cell{i};
time_indices = ac(:,1);

% Find mean and standard deviation
num_comps = size(ac,2);
ac_mean = mean(ac(:,2:num_comps),2);
ac_deviation = std(ac(:,2:num_comps),0,2);


% Find Kendall Tau of mean ac before and after peak
[max_ac,max_index] = max(ac_mean);
tpeak = time_indices(max_index);

% PreTau (2dp)
corMatrix = corr([time_indices(1:max_index),ac_mean(1:max_index)],'type','Kendall');
ktau_pre = round(corMatrix(1,2),2);

% PostTau (2dp)
corMatrix = corr([time_indices(max_index:end),ac_mean(max_index:end)],'type','Kendall');
ktau_post = round(corMatrix(1,2),2);


% Plot range
xlow=0; xhigh=100;
ylow = [0.2,0.45,0.5,0.57,0.57,0.57,0.6,0.6,0.6,0.65,0.65,0.65];
yhigh = [0.9,0.9,0.9,0.9,0.9,0.9,0.9,0.9,0.9,0.85,0.85,0.85];

% plot with shaded error bars
shadedErrorBar(time_indices,ac_mean,ac_deviation,'k'); 
hold on

% Plot vertical line at tpeak
plot(tpeak*ones(1,1000),linspace(ylow(i)+0.03,yhigh(i),1000),':k','LineWidth',1.5)
axis([xlow xhigh ylow(i) yhigh(i) ])

% Specifications
set(gca,'FontSize',fs,'YColor','k')
ylabel('Lag-1 AC')
xlabel('Time (years)')



% Kendall tau text
ktxt_pre = ['\tau = ',num2str(ktau_pre,'%.2f')];
ktxt_post = ['\tau = ',num2str(ktau_post,'%.2f')];
text(0.02,0.08,ktxt_pre,'FontSize',fs,'Units','normalized')
text(0.99,0.08,ktxt_post,'FontSize',fs,'Units','normalized','HorizontalAlignment','Right')


% subfigure label
title(labels(i),'Units','normalized','Position',[0,1],'HorizontalAlignment','Left')
    

end


% Export at 300 dpi 
print('../../Research/vaccine_behaviour_16/demetri_figures/s8','-dpdf','-r300')


