% returns the chebyshev nodes over (-H, H)
function C = cheb_nodes(H, N)
	C= arrayfun(@(k) chebyshev(k, N), 1:N);
	C *= H;
end

% returns kth zero of the n-degree Chebyshev polynomial
% over (-1, 1)
function ans = chebyshev(k, N)
	ans = cos( (2*k-1) * pi / (2*N) );
end

