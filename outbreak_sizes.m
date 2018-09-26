% Script to work out the outbreak sizes of the exogeneous system wtih
% constant risk.
% Keep to one realisation and tmax large

clear
close all
tStart = tic;

%-----------------------------
% Run  simulation
%------------------------------

% Input variables - see vacc_sde.m for definitions
y0 = [0.01,1e-4,0.99,0]; % y=[S,I,x,C]
tmax = 10000;
k = 500;
choose_risk = 3;
wl = 1.8e-4;              
wh = 1.8e-4;
d = 2e-4;
num_realisations = 1; 
sigma = 0.005;  

% Run vacc_sde
% Data is a matrix with columns [t,w,y1,y2,...,yn]
data = vacc_sde( y0, tmax, k, choose_risk, wl, wh, d, num_realisations, sigma );


% Plot a realisation using tri_plot
wcrit = d;
tri_plot(data,'',1, wcrit)



%------------------------------
% Find outbreak sizes
%-------------------------------

% Run epi_intervals to find intervals of the epidemics
Ithresh = 1e-6;
Iseries = data(:,4);
intervals = epi_intervals(Iseries,Ithresh);

% Work out size of epidemics (total number infected during I>Ithresh)
Cseries = data(:,6);
Cboundaries = Cseries(intervals);
epi_sizes = Cboundaries(:,2)-Cboundaries(:,1);


% Make a histogram of outbreak size
figure()

% Set figure size
set(gcf,'Units','Inches')
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) 10.5 6.5],'PaperPositionMode','Auto','PaperSize',[10.5 6.5])

histogram(epi_sizes);
xlabel('Outbreak Size (proportion of population that got infected)')
ylabel('Frequency')
title('Dynamic vaccination uptake')


%---------------------------------
% Export epi_sizes
%------------------------------

csvwrite('epi_sizes_exo.csv',epi_sizes)


% End time counter
tEnd = toc(tStart);
fprintf('%d minutes and %f seconds\n',floor(tEnd/60),rem(tEnd,60));

% To save figure use print('plots/plot_','-dpdf','-r0')

