%
% This is a terminal event function, called by the ode solver.
%
function [value,isterminal,direction] = pursuit_events(t, P, dmin, target_number)

    value = norm( target(t,target_number) - P(1:2), 2) - dmin;
    if value <= 0
        disp('target acquired')
    end

    isterminal = 1;   % Stops the integration
    direction = -1;   % Negative direction
