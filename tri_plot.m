function tri_plot( data, my_title, total_plots, wcrit )
% tri_plot puts three plots together in the same figure, set up for
% vaccination model.
% 
%
% Input arguments:
%       data - is a matrix with form [t,w,y1,y2,...,yn]
%       title - a string
%       num_plots - number of plots to produce < num_realisations
%       wcrit - equals d, social pressure

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

ax1 = subplot(3,1,1); % top subplot
ax2 = subplot(3,1,2); % middle subplot
ax3 = subplot(3,1,3); % bottom subplot

% time column
t = data(:,1);

% top plot
subplot(ax1)
plot(t,data(:,3*plot_num+2))
axis([-inf,inf,0.5,1])
set(gca,'FontSize',12)
ylabel('Vaccine Uptake') % proportion of newborns getting vaccinated
title(my_title)

% middle plot
subplot(ax2)
plot(t,data(:,3*plot_num+1))
axis([-inf,inf,-inf,inf])
set(gca,'FontSize',12)

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[2,0,0])
ylabel( 'Prop. Infected')

% bottom plot
subplot(ax3)
plot(t,data(:,2),t,ones(1,length(t))*wcrit)
axis([-inf,inf,0,7e-4])
set(gca,'FontSize',12)

ylabp = get(gca,'YLabel'); % move y label to the left
set(ylabp,'Position',get(ylabp,'Position')-[2,0,0])
xlabel('t (years)')
ylabel(ax3,'w(t)')
% legend
legend('w(t)','wcrit','Location','southeast');
end


end

