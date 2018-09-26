function bi_plot( data, my_title, total_plots )
% bi_plot puts two plots together in the same figure, set up for
% vaccination model.
% 
%
% Input arguments:
%       data - is a matrix with form [t,w,y1,y2,...,yn]
%       title - a string
%       num_plots - number of plots to produce < num_realisations

% error check
num_realisations = (size(data,2)-2)/3;
if total_plots > num_realisations
    disp('Number of plots exceeds number of realisations!')
    total_plots = num_realisations;
end

% make plots

for plot_num = 1:total_plots;
figure()

% Set figure size
set(gcf,'Units','Inches')
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) 10.5 6.5],'PaperPositionMode','Auto','PaperSize',[10.5 6.5])

ax1 = subplot(2,1,1); % top subplot
ax2 = subplot(2,1,2); % bottom subplot

% time column
t = data(:,1);

% top plot
subplot(ax1)
plot(t,data(:,3*plot_num+2))
axis([-inf,inf,0.5,1])
set(gca,'FontSize',12)
ylabel('Vaccine Uptake')
title(my_title)

% bottom plot
subplot(ax2)
plot(t,data(:,3*plot_num+1))
axis([-inf,inf,-inf,inf])
set(gca,'FontSize',12)

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[0,0,0])
ylabel( 'Prop. Infected')
xlabel( 'time (years)')

end

end

