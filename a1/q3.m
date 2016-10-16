function unused = q3() 
	degs = [2,7,16];
	hs = arrayfun(@(x) 2^(-x), 0:7);
	chebys = {'equidist', 'cheby'};
	bools = [false, true];

	errvh = zeros(length(hs), 2);

	for k= 1:length(chebys)
		for i= 1:length(degs)
			% error plots
			errors = zeros(1,length(hs));
			for j = 1:length(hs)
				[~, ~, ~, errors(j)] = test_lagrange(2*hs(j), degs(i), @(x) cauchy(x), bools(k));
			end

			chebyORequidist = chebys{k}
			deg = degs(i)
			errvh(:, 1) = hs';
			errvh(:, 2) = errors';
			errvh = errvh

			loglog(hs, errors);
			print(["q3plots/error", num2str( degs(i) ), chebys{k},".png"], "-dpng")
		end
	end

	% u(x) vs. p(x) plot for n=100
end

function ans = cauchy(x)
	ans = (1+25*x.^2).^(-1);
end

q3()
