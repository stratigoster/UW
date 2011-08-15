% refine.m

function tt = refine(t, r)
    n = length(t);
    tt = zeros(1,r*(n-1)+1);
    for k = 1:n-1
        i = r*(k-1)+1;
        dt = t(k+1) - t(k);
        for j = 0 : r-1
            tt(i+j) = t(k) + j*dt/r;
        end
    end
    tt(r*(n-1)+1) = t(n);
