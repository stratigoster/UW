%
%    Simulation of pursuit problem
%

% Some simulation parameters
target_number = 2;
force = 6;
K = 0;
dmin = 0.1;

args = [ force; K; target_number ];
     
tspan = [0 10]; % Set start and end times for computation
yStart = zeros(4,1);     % rocket starting position


% Set options for the ODE solver
options = odeset('RelTol',1.0e-3,'AbsTol',1.0e-6,'Events',@(t,P) pursuit_events(t,P,dmin,target_number));

% Call the ODE solver (Runge-Kutta 4/5)
[t,y] = ode45(@(t,z) missile(t,z,args), tspan, yStart, options);




%-------------------------------------------------------------
%
% Everything below here is just plotting & visualization
%
%-------------------------------------------------------------


% Plot missile and target positions over time.
figure(1);
N = length(t);
T = zeros(N,2); % position of target
for i = 1:N
    T(i,:)= target(t(i), target_number)';
end 
plot(y(:,1),y(:,2),'rx-', T(:,1),T(:,2),'b');
xlabel('x'); ylabel('y'); axis equal;
title('Trajectories of target and missile, scenario (c)');


% Plot distance from missile to target over time.
figure(2);
dist = zeros(size(t));
for i = 1:N
    relPos = T(i,:) - y(i,1:2);
    dist(i) = norm(relPos,2);
end 
plot(t,dist);
xlabel('Time'); ylabel('Distance');
title('Distance between rocket and target over time.');


% Animate the two trajectories
animate_pursuit(t,y,T);
