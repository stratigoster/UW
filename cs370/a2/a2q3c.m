% a2q3c.m

% plot simple piecewise interpolating curve of original data
plot( x, y, 'b--' );
hold on

% plot smooth version of ampersand
tref = refine(t, 100);
plot( ppval(xpp, tref), ppval(ypp, tref), 'r' )
title('Plot of ampersand with refinement factor of 100')

% disable grid and axes
axis off
grid off
