function  grid_plot( data_collect )
% grid_plot creates a grid of plots from data
%
%
% Input arguments:
%       data_collect - is a matrix with form [t,w,y1]x[t,w,y1]x...
%       title - a string


% number of entries
num_epi = size(data_collect,3);

figure()
for i=1:min(num_epi,25)
    % time column
    t = data_collect(:,1,i);
subplot(5,5,i)
plot(t,data_collect(:,5,i))
axis([-inf,inf,0,1])
ylabel('Proportion Vaccinators')
xlabel('t (years)')
end


end


