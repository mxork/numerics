function yq = herminterp2(y1, y2, dy1, dy2, xq)
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

function unused = q51()
	[G, Exact, ApprxC, ErrorC] = test_lagrange(1, 4, @(x) sign(x), true);
	Apprx = herminterp2(-1, 1, 0, 0, G);
	Error = max(abs(Apprx - Exact));

	Error
	ErrorC
	plot(G, Exact, G, Apprx, G, ApprxC)
	print -dpng q5plots/chebyshevVShermite.png
end

function Yq = herminterp(Y1, Y2, Xq)
	N = length(Y1);

	% general 2*n degree polynomial
	Pn = ones(1, 2*N);

	% each row should be d^n of a general 2*n polynomial,
	% evaluated at -1, 1
	A = zeros(2*N);
	

	% general P evaled at 1
	A(1, :) = Pn;
	for i = 2:N
		A(i, 1:(2*N -i +1)) = polyder( A(i-1, 1:( 2*N - i + 2)) );
	end

	% GP eval at -1 -> flips signs
	for i=1:N
		j = i+N;
		A(j, :) = A(i, :);

		for k = 1:2*N
			if mod(i+k, 2)==0
				A(j,k) *= -1;
			end
		end
	end	

	Ai = inv(A);
	% right side is +ve, left side is -ve
	Y3 = [Y2, Y1];

	Yq = arrayfun(@(x) EvalHermMatrix(Ai, Y3, x), Xq);
end

function ans = EvalHermMatrix(Ai, Y3, xq)
	ans = 0;
	N = length(Y3)/2;

	for i = 1:2*N
		ans += Y3(i)*polyval( Ai*(eye(2*N)(:, i) ), xq); 
	end
end

degs = [5,7,9,11]
for di = 1:length(degs)
	deg = degs(di)+1

	[G, Exact, ApprxC, ErrorC] = test_lagrange(1, deg, @(x) sign(x), true);
	L = R =zeros(1, deg); 
	L(1) = -1;
	R(1) = 1;

	Apprx = herminterp(L, R, G);
	plot(G, Exact, G, Apprx, G, ApprxC)
	print(["q5plots/chebyshevVShermite", num2str(deg-1), ".png"] , "-dpng");
end
