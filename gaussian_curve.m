% Gaussian curve

c = 1; % time scaling
tmax = 600;
wl = 0.1e-4;
wh = 0.4e-4;
dt=1e-4;

wfun = @(t) (wh-wl)*exp(-c*(t-tmax/2)^2) + wl;

t=0:dt:tmax;
wvals
