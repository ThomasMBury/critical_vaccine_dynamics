figure()




% Import data
var_struct = importdata('var_data/var_lin.txt');
var = var_struct.data;

% Find mean and standard deviation
num_comps = size(var,2);
var_mean = mean(var(:,2:num_comps),2);
var_deviation = std(var(:,2:num_comps),0,2);

% plot
time_indices = var(:,1); 
plot(time_indices,var_mean,'Color',[0.5,0.2,0],'LineWidth',lw);
% shadedErrorBar(time_indices,ac_mean,ac_deviation,'r'); 

% Plot range
xlow=0; xhigh=100; ylow=5.5e-3; yhigh=7.5e-3;
axis([xlow xhigh ylow yhigh ])

% Specifications
set(gca,'xticklabel',[],'FontSize',12,'YColor',[0.5,0.2,0])

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[1,0,0])
ylabel('Variance')

% Draw window arrow
xpos_arrow = [0.135,0.28];
ypos_arrow = [0.33,0.33];

xpos_text = 10;
ypos_text = 6.3e-3; 

annotation('doublearrow',xpos_arrow,ypos_arrow)
text(xpos_text,ypos_text,'rolling window','HorizontalAlignment','center','FontSize',12)



p1 = [2 3];                         % First Point
p2 = [5 3];                         % Second Point
dp = p2-p1;                         % Difference
figure(3)
quiver(p1(1),p1(2),dp(1),dp(2),0)
axis([0  10    0  10])






