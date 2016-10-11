function yq = herminterp(y1, y2, dy1, dy2, xq)
	A = [
		-1, 1, -1, 1; 
		1, 1, 1, 1;
		3, -2, 1, 0;
		3, 2, 1, 0;
	];

	Ai = inv(A);

	L10 = y1*Ai*[1,0,0,0]';
	L11 = dy1*Ai*[0,0,1,0]';

	R10 = y2*Ai*[0,1,0,0]';
	R11 = dy2*Ai*[0,0,0,1]';

	yq = polyval(L10, xq) + polyval(L11, xq) + polyval(R10, xq) + polyval(R11, xq);
end

[G, Exact, ApprxC, ErrorC] = test_lagrange(1, 4, @(x) sign(x), true);
Apprx = herminterp(-1, 1, 0, 0, G);
Error = max(abs(Apprx - Exact));

Error
ErrorC
plot(G, Exact, G, Apprx, G, ApprxC)
print -dpng q5plots/chebyshevVShermite.png
