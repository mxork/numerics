% returns the dividided diff matrix:
% x0 f(x0)
% x1 f(x1) [x1, x0]f
% X is grid vector (x1, ..., xN)
% func is function to sample
function A = div_diff(X, func)
	N = length(X);
	A = zeros(N);

	%populate first column
	% TODO vectorize
	for n = 1:N
		A(n, 1) = func(X(n)) ;
	end

	for k = 2:N
		for n = k:N
			%start on kth row down, do kth divdiff.
			A(n,k) = ( A(n,k-1) - A(n-1, k-1) ) / ( X(n) - X(n-k+1) );
		end
	end
end

% this is probably not the write way to code a polynomial
function ans = div_diff_interp(A, X, x)
	ans = 0;
	N = length(A);

	for i =1:N
		partial = A(i, i);

		for j= 1:(i-1)
			partial *= x - X(j)	;
		end

		ans += partial;
	end
end


% returns kth zero of the n-degree Chebyshev polynomial
function ans = chebyshev(k, n)
	ans = cos( (2*k-1) * pi / (2*n) );
end

function C = cheb_nodes(N)
	C = arrayfun(@(i) chebyshev(i, N), 1:N);
end

function [G, Exact, Apprx, Error] = test_lagrange(H, N, f)
	% G is the test grid
	G = linspace(-H, H, 20*N);
	X = linspace(-H, H, N);

	Exact = f(G);

	A = div_diff(X, @(x) f(x));
	Apprx = arrayfun( @(x) div_diff_interp(A, X, x), G);

	errors = arrayfun( @(x,y) abs(x-y), Exact, Apprx);
	Error = max(errors);
end

% question 2
no_pow = 8;
degs = [2, 7, 16];
hs = arrayfun( @(x) 10^(-x), 1:no_pow);
errors = zeros(3,no_pow);

for j = 1:3
	for i = 1:no_pow
		h = hs(i);
		deg = degs(j);
		[~, ~, ~, errors(j, i)] = test_lagrange(h*100*pi, deg, @(x) sin(x));
	end	
end

errors
loglog(hs, errors)
uiwait()

