%
% function [a, b, c] = MySpline(x, y)
%
% Input:
%
%   x and y are vectors (same size) of x-values and y-values, corresponding
%   to points in the xy plane.  The x-values must be in increasing order.
%
% Output:
%
%   a, b and c are vectors of parameters corresponding to the special form
%   for cubic polynomials (see Course Notes, Section 2.2.3). Note that "a"
%   is indexed starting at 1, so a_0 from the Course Notes is stored in
%   position a(1), etc. The vectors "b" and "c" are indexed the same as
%   in the Course Notes.
%
%   Hence...
%     a(1) = a_0
%     a(2) = a_1          b(1) = b_1        c(1) = c_1
%          :                   :                 :
%     a(n) = a_(n-1)    b(n-1) = b_(n-1)  c(n-1) = c_(n-1)
%
%   The polynomial piece is evaluated using
%
%     p_k(x) = a(k)*(x(k+1)-xvals(m))^3/(6*hk) + ...
%              a(k+1)*(xvals(m)-x(k))^3/(6*hk) + ...
%              b(k)*(x(k+1)-xvals(m)) + c(k)*(xvals(m)-x(k));
%
%   where hk = x(k+1) - x(k).  See the function
%
%     EvaluateMySpline
%
%   for more details.
%
%
function [a b c] = MySpline(x, y)

    n = length(x);
    a = zeros(n,1);
    b = zeros(n-1,1);
    c = zeros(n-1,1);
    h = zeros(n-1,1);
    
    for i = 1:n-1
        h(i) = x(i+1) - x(i);
    end

    A = zeros(n-2,n-2);

    for i = 1:n-2
        A(i,i) = 2*(h(i)+h(i+1));
        if i ~= n-2
            A(i,i+1) = h(i);
        end
        if i ~= 1
            A(i,i-1) = h(i);
        end
    end

    C = zeros(n-2,1);

    for i = 1:n-2
        C(i) = 6*( (y(i+2)-y(i+1))/h(i+1) - (y(i+1)-y(i))/h(i) );
    end

    B = A\C;
    
    a = [0;B;0];
    
    for i = 1:n-1
        b(i) = y(i)/h(i) - a(i)*h(i)/6;
        c(i) = y(i+1)/h(i) - a(i+1)*h(i)/6;
    end
