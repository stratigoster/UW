%
% function S = EvaluateMySpline(x, a, b, c, xvals)
%
% Input:
%
%   x is a vector of x-values for the spline nodes, in increasing order
%
%   xvals is a vector of x-values where you want to evaluate the cubic
%     spline.  These should also be in ascending order.
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
%   where hk = x(k+1) - x(k).
%
% Output:
%
%   S is a vector the same size as xvals holding the value of the spline
%     corresponding to the given x-values in xvals.
%
function S = EvaluateMySpline(x, a, b, c, xvals)

    n = length(x);
    
    if length(a) ~= n
        disp(['ERROR: Array "a" must have length ' num2str(n)]);
    elseif length(b) ~= n-1
        disp(['ERROR: Array "b" must have length ' num2str(n-1)]);
    elseif length(c) ~= n-1
        disp(['ERROR: Array "c" must have length ' num2str(n-1)]);
    end
    
    S = zeros(size(xvals)); % Pre-allocate output array (faster)
    
    k = 1; % this is the current polynomial piece
    hk = x(k+1) - x(k);
   
    for m = 1:length(xvals)
        
        % As long as the next x-value is not on the current piece
        while xvals(m) > x(k+1)
            % Go to next piece
            k = k + 1;
            hk = x(k+1) - x(k);
        end
        
        S(m) = a(k)*(x(k+1)-xvals(m))^3/(6*hk) + ...
               a(k+1)*(xvals(m)-x(k))^3/(6*hk) + ...
               b(k)*(x(k+1)-xvals(m)) + c(k)*(xvals(m)-x(k));
    end
    
    
    
    