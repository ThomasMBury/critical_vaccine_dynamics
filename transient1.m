% Simulation of a transient trajectory near E_1 using vacc_sde
% Instead of taking many realizations, take one realization for a long time
% and pick out epidemics

clear
close all

% Input variables - see vacc_sde.m for definitions
y0 = [0.01,1e-4,0.99];
tmax = 10000;
k = 1000;
choose_risk = 3;
wl = 1e-4;              
wh = 1e-4;
d = 5e-4;
num_realisations = 1;     
sigma = 0.015;            

% Run vacc_sde
% Output is matrix with cols [t,w,y1] (one realization)
% Recall y has cols [S,I,x]
data = vacc_sde( y0, tmax, k, choose_risk, wl, wh, d, num_realisations, sigma );


% Plot realisations using bi_plot
empty_title='';
total_plots = 20;
wcrit = d;
bi_plot(data,empty_title,total_plots)


% Filter the data for saving
tinit = 0;
tfin = tmax;
num_comps = 1000;

data_filt = time_filter(data,tinit,tfin,num_comps);

% Save the filtered data to csv file for statistical analysis in R
% csvwrite('sim_data/simdata_trans_multiple.txt',data_filt)



%---------------------------
% exectute this code or not
%--------------------------
perform=1;
if perform ==1
% Find times of epidemic onsets
    
    I = data(:,4);        % Infected time series
    t = data(:,1);      % Time vector
    dt = t(2)-t(1);     % Time step
    num_comps = size(data,1);   % Components to series
    I_thresh = 2e-3;            % no. infected that declares an epidemic
    epi = [];                   % vector of times of epidemic onsets
    
    
    i=1;                 
    while i <= num_comps
        if I(i) < I_thresh          % If below threshold move on
            i=i+1;
        else                        % If above threshold...
            epi = [epi,t(i)];       % Record the onset
            
            while I(i) >= I_thresh  % Don't include other times during epidemic
                i = i+1;
            end
        end
    end
    
    
% Filter to times of epidemic onsets given clearance+ years of disease free

       
epi_filt = [];
clearance = 20;

% Case j=1
if (epi(1) > clearance) 
    epi_filt = epi(1);
end
% Run through all epidemics
for j=2:length(epi)
    if (epi(j)-epi(j-1) > clearance)
        epi_filt = [epi_filt, epi(j)];
    end
end
   



% Use time_filter.m to extract the data 50 years before each onset
% Collect the data up into 3 dim array data_collect

new_comps = 400;
data_collect = zeros(new_comps,3*num_realisations+2,length(epi_filt));

for i = 1:length(epi_filt)
    tinit = epi_filt(i)-clearance;
    tfin = epi_filt(i);
    data_filt = time_filter( data, tinit, tfin, new_comps );
    data_collect(:,:,i) = data_filt;
end


% Reform data collect for analysis in R
% Form [t,w,y1,y2,...,yn]

    % time vector
    t = linspace(0,20,400);
    data_reform = zeros([400,2+3*length(epi_filt)]);
    data_reform(:,1)=t;
    for j=1:length(epi_filt)
        data_reform(:,3*j:3*j+2) = data_collect(:,3:5,j);
    end
    

% Save data_reform as csv file
csvwrite('sim_data/simdata_transients.txt',data_reform)
    



% Make plots for visualization
% trans_title = 'Transient Epidemic Time Section';
%
% for i=1:min(3,size(data_collect,3))
%    figure(i+1)
%    tri_plot( data_collect(:,:,i), trans_title, 1, wcrit )
% end


% Plot grid of vaccinator time series
% figure(6)
% grid_plot(data_collect)


% Save figure with print('Plots/plot_','-dpdf','-r0')
    
end    




