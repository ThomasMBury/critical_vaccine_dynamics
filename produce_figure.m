% Code to fully specify figure



% Set parameter values

width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 8;      % Fontsize
lw = 1.5;      % LineWidth
msz = 8;       % MarkerSize


% Figure properties
figure(1);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
plot([1,3,2],'LineWidth',lw,'MarkerSize',msz); %<- Specify plot properites
xlim([-pi pi]);
legend('f(x)', 'Location', 'SouthEast');
xlabel('x');
title('Improved Example Figure');

% Set Tick Marks
set(gca,'XTick',-3:3);
set(gca,'YTick',0:10);

% Here we preserve the size of the image when we save it.
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);

