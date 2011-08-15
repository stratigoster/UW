function dzdt = ballistics(t,Y)
    % Y(1) = x(t)
    % Y(2) = y(t)
    % Y(3) = x'(t)
    % Y(4) = y'(t)
    K = 0.2;
    g = 9.81;
    dzdt = [ Y(3), Y(4), -K*Y(3), -g-K*Y(4) ];
