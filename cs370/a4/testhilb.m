err = zeros(6,1);
kond = zeros(6,1);
for n = 2:2:12
    A = hilb(n);
    b = ones(n,1);
    for i = 1:n
        b(i) = i/(i*i + 1);
    end
    x = A\b;
    x_exact = invhilb(n)\b;
    err(n/2) = norm(x_exact - x, inf)/norm(x);
    kond(n/2) = cond(A,inf);
end
err
kond
