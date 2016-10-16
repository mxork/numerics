function unused = q3() 
	degs = [2,7,16,100];
	hs = arrayfun(@(x) 2^(-x), 0:9);
	chebys = {'equidist', 'cheby'};
	bools = [false, true];

	for k= 1:length(chebys)

		errvh = zeros(length(hs), length(degs)+1);
		for i= 1:length(degs)
			% error plots
			errors = zeros(1,length(hs));
			for j = 1:length(hs)
				[~, ~, ~, errors(j)] = test_lagrange(2*hs(j), degs(i), @(x) cauchy(x), bools(k));
				errvh(j, i+1) = errors(j);
			end

			chebyORequidist = chebys{k}
			deg = degs(i)
		end

		errvh(:, 1) = hs';
		errvh = errvh
		errvht = errvh';
		loglog(
			errvht(1,:), errvht(2,:),
			errvht(1,:), errvht(3,:),
			errvht(1,:), errvht(4,:),
			errvht(1,:), errvht(5,:)
			);

		%legend("n=2", "n=7", "n=16", "n=100");
		print(["q3plots/error", chebys{k},".png"], "-dpng")
	end


	% u(x) vs. p(x) plot for n=100
	[G, Exact, Apprx, ~] = test_lagrange(1, 100, @(x) cauchy(x), false);
	plot(G, Exact, G, Apprx)
	title "Equidistant"
	print("q3plots/plotequi.png", "-dpng", "-S600,400")

	[~, ~, ApprxC, ~] = test_lagrange(1, 100, @(x) cauchy(x), true);
	plot(G, Exact, G, ApprxC)
	title "Chebyshev"
	print("q3plots/plotcheby.png", "-dpng")

end

function ans = cauchy(x)
	ans = (1+25*x.^2).^(-1);
end

q3()
