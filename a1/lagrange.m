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

% question 2

%test grid
G = linspace(-1,1,1000);
Exact = sign(G);
Ns = [2, 7, 16];
Hs = arrayfun(@(x) 10^(-x), 1:4);

Xapprx = zeros(length(Ns), length(G) );
Xerror = zeros(length(Ns), length(Hs));

Capprx = zeros(length(Ns), length(G) );
Cerror = zeros(1, length(Ns)); 

for iN = 1:length(Ns)
	for iH = 1:length(Hs)
		N = Ns(iN);
	   	H = Hs(iH);

		X = linspace(-H, H, N);

		A = div_diff(X, @(x) sign(x));
		Xapprx(iN, :) = arrayfun( @(x) div_diff_interp(A, X, x), G);

		errors = arrayfun( @(x,y) abs(x-y), Exact, Xapprx(iN, :));
		Xerror(iN, iH) = max(errors)
	end

	% C = cheb_nodes(N)
	%	A = div_diff(C, @(x) sign(x));
	%	Capprx(iN, :) = arrayfun( @(x) div_diff_interp(A, C, x), G);
	%	errors = arrayfun( @(x,y) abs(x-y), Exact, Capprx);
	%	Cerror(iN) = max(errors)
end

loglog(Hs, Xerror(2, :))
uiwait()
