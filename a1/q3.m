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
		%legend("n=2", "n=7", "n=16", "n=100");
		errorplot(["q3plots/error", chebys{k},".png"], errvht(1,:), errvht(2:length(errvht(:,1)), :),
			arrayfun(@(deg) ['n=', num2str(deg)], degs, 'UniformOutput', false));
	end


	% u(x) vs. p(x) plot for n=100
	[G, Exact, Apprx, ~] = test_lagrange(1, 100, @(x) cauchy(x), false);
	graphplot("q3plots/plotequi.png", G, [Exact; Apprx], {'exact', 'apprx'})

	[~, ~, ApprxC, ~] = test_lagrange(1, 100, @(x) cauchy(x), true);
	graphplot("q3plots/plotcheby.png", G, [Exact; ApprxC], {'exact', 'apprx'})
end

function ans = cauchy(x)
	ans = (1+25*x.^2).^(-1);
end

q3()
