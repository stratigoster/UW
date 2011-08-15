% Cannon.m

theta = 60;     % Angle of initial velocity
S = 200;        % Initial speed
tspan = [0 30]; % Set start and end times for computation

% Set up initial state
yStart = [0;0;                   % initial position (0,0)
          S*cos(theta/180*pi);   % x velocity
          S*sin(theta/180*pi)];  % y velocity


[t,y] = MyOde(@ballistics, tspan, yStart, 1000, @ballistics_events);


plot([0 y(end,1)], [0 0], 'k-', y(:,1), y(:,2), 'r.-', 'MarkerSize', 3);
axis equal;
title(['\theta = ' num2str(theta) '^\circ: Cannon ball landed at ' num2str(y(end,1)) 'm'], 'FontSize', 18);

