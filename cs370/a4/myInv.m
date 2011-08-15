function B = myInv(A)
	dim = size(A);
	if dim(1) ~= dim(2)
		B = dim;
	elseif cond(A)==Inf
		B = 0;
	else
		[L U P] = lu(A);
		n = dim(1);
		B = zeros(n,n);
		I = eye(n,n);
		for i = 1:n
			b = I(:,i);
			y = L\(P*b);
			x = U\y;
			B(:,i) = x;
		end
	end