% Solve vaccinator dynamical system using ode45

clear all

% Parameter values - time unit years
u=1/50;                 % Birth - Death rate
R0=10;                  % R0 value
g=365/10;               % Recovery rate
b=R0*(g+u);             % Transmission rate
k=1000;                 % Imitation rate * Sensitivity to disease prev (m)
w=1/1000;               % Relative vaccination to infection risk
a=365*1e-8;             % Immigration factor

% Display critical value of omega
w0=u/(g+u)*(1-1/R0);
text=['Critical value of w is w0 = ',num2str(w0)];
disp(text)

% System of odes
system = @(t,y)[u*(1-y(3))-b*y(1)*y(2)-u*y(1);...
                b*y(1)*y(2)-g*y(2)-u*y(2)+a;...
                k*y(3)*(1-y(3))*(-w+y(2))-a];
            
tspan=[0,60];
y0=[0.05;0.0001;0.95];

[t,y]=ode45(system,tspan,y0);

figure(1)
plot(t,y(:,2))
ylabel('Proportion Infected')

figure(2)
plot(t,y(:,3))
ylabel('Proportion Vaccinators')
            
            