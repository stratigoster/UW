% a2q3b.m

% plot ampersand with refinement factor of 3
tref = refine(t, 3);
plot( ppval(xpp, tref), ppval(ypp, tref) )
title('Plot of ampersand with refinement factor of 3')

% disable grid and axes
grid off
axis off
