% Script to construct S2 for Demetri's paper

% AC for linearly increasing risk
% Grid showing output for various rolling window sizes

clear
close all


% Import the data into a cell array (each element of the cell may have different
% dimensions!)
ac_cell = cell(1,12);
for j=1:12
    ac_struct = importdata(strcat('ac_data/ac_lin_win',num2str(j),'.txt'));
    ac_temp = ac_struct.data;
    
    % Work with data up to tcrit
    tcrit = 80;
    time_indices = ac_temp(:,1);
    temp = abs(time_indices-tcrit);
    [val,idx] = min(temp);
    ac_cell{j} = ac_temp(1:idx,:);
    
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
fs = 10;

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

% Find Kendall Tau of mean var (3dp)
corMatrix = corr([time_indices,ac_mean],'type','Kendall');
ktau = round(corMatrix(1,2),3);

% plot with shaded error bars
shadedErrorBar(time_indices,ac_mean,ac_deviation,'k'); 

% Plot range
xlow=0; xhigh=100; ylow=-inf; yhigh=inf;
axis([xlow xhigh ylow yhigh ])

% Specifications
set(gca,'FontSize',fs,'YColor','k')
ylabel('Lag-1 AC')
xlabel('Time (years)')

% Kendall tau text
ktxt = ['\tau = ',num2str(ktau,'%.2f')];
text(0.67,0.1,ktxt,'FontSize',fs,'Units','normalized')

% subfigure label
title(labels(i),'Units','normalized','Position',[0,1],'HorizontalAlignment','Left')
    

end

% Export at 300 dpi 
print('../../Research/vaccine_behaviour_16/demetri_figures/s2','-dpdf','-r300')






