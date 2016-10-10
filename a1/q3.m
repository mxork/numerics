function unused = q3() 
	degs = [2,7,16];
	hs = arrayfun(@(x) 10^(-x), 0:5);
	chebys = {"cheby", "equidist"}
	bools = [true, false]

	for k= 1:length(chebys)
		for i= 1:length(degs)
			% error plots
			errors = zeros(1,length(hs));
			for j = 1:length(hs)
				[~, ~, ~, errors(j)] = test_lagrange(hs(j), degs(i), @(x) cauchy(x), bools(k));
			end

			chebys(k)
			degs(i)
			errors
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
