
% Assignment 2 Question 2 Test Script
%
% If you get your MySpline function working properly, it should return
% the "a", "b" and "c" values below.

y = [1 3 4 2 3 1];
t = [0 1 2 3 4 5];

[a b c] = MySpline(t, y);

% Comment these lines out once MySpline is working
%a = [     0    0.1148   -6.4593    7.7225   -6.4306         0];
%b = [1.0000    2.9809    5.0766    0.7129    4.0718];
%c = [2.9809    5.0766    0.7129    4.0718    1.0000];

tt = linspace(t(1), t(end), 100);

S = EvaluateMySpline(t, a, b, c, tt);

plot(t, y, 'ro', tt, S);

