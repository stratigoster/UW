A = ones(2,4);
myInv(A)

A = zeros(3,3);
myInv(A);
%inv(A);


for k = 7:2:13
    A = hilb(k);
    myInv(A)
    %inv(A)
end
