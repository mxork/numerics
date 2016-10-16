% over the interval (-H, H) with N evenly spaced points, test
% Lagrange interpolation for the function f.
% Returns 
%	G: the test mesh (for plotting), 
%	Exact: precise values of f evaluated for each xi in G, 
%	Apprx: lagrange interpolation for each xi in G, and
%   Error: max error over the interval.
function [G, Exact, Apprx, Error] = test_lagrange(H, N, f, useChebyshev=false)
	% G is the test grid; 20 times as fine as sample grid
	G = linspace(-H, H, 20*N);

	% X is the sampling grid
	if useChebyshev 
		X = linspace(-H, H, N+1); %+1, since n-1 polynomial
	else
		X = cheb_nodes(H, N+1);
	end

	Exact = f(G);

	A = div_diff(X, @(x) f(x));
	Apprx = arrayfun( @(x) div_diff_interp(A, X, x), G);

	errors = arrayfun( @(x,y) abs(x-y), Exact, Apprx);
	Error = max(errors);
end

% returns the interp polynomial [a_n ... a_0]
function P = vander_interp_poly(X, func)
	N = length(X);
	Y = arrayfun(func, X);
	A = zeros(N);
	A(:, 1) = ones(N, 1); 

	for i=1:N
		for j=2:N
			A(i,j) = X(i)*A(i, j-1);
		end
	end

	Ai = inv(A);
	P = Ai*Y;
end

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
% estimate the value f(x) using the divided difference matrix A,
% and the sample points X=(x1 ... xn)
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


