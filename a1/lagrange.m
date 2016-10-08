% returns the dividided diff matrix:
% x0 f(x0)
% x1 f(x1) [x1, x0]f
% X is grid vector (x1, ..., xN)
% func is function to sample
function A = div_diff(X, func)
	N = length(X)
	A = zeros(N)

	%populate first column
	% TODO vectorize
	for n = 1:N
		A(n, 1) = func(X(n)) 
	end

	for k = 2:N
		for n = k:N
			%start on kth row down, do kth divdiff.
			A(n,k) = ( A(n,k-1) - A(n-1, k-1) ) / ( X(n) - X(n-k+1) )
		end
	end
end

% this is probably not the write way to code a polynomial
function ans = div_diff_interp(A, X, x)
	ans = 0
	N = length(A)

	for i =1:N
		partial = A(i, i)

		for j= 1:(i-1)
			partial *= x - X(j)	
		end

		ans += partial
	end
end

function ans = chebyshev(k, n)
	ans = cos( (2*k-1) * pi / 2*n)
end

X = linspace(0,1,10) 
A = div_diff(X, @(x) sin(x))
ans = div_diff_interp(A, X, 0.46)
display(ans)
