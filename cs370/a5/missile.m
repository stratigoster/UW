%
% This is the function that is called by the ode solver.
% It implements the dynamics for the missile in the pursuit problem.
%
function dzdt = missile(t, z, args)
    % z(1) = x
    % z(2) = y
    % z(3) = x'
    % z(4) = y'

    F = args(1);
    K = args(2);
    target_number = args(3);
    T = target(t, target_number);
    dx = T - z(1:2);
    u = dx/norm(dx,2);

    dzdt = [ z(3); z(4); F*u(1)-K*z(3); F*u(2)-K*z(4) ];
