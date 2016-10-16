function unused = q4()
	funcs = {
		@(x) sign(x),
		@(x) sin(x),
		@(x) abs(x),
		@(x) x.^5,
		@(x) (1+25.*x.^2).^(-1)
	};

	funcnames = {
		'sign',
		'sin',
		'abs',
		'quintic',
		'cauchy'
	};

	intmethods = {
		'nearest',
		'linear',
		'spline',
		'pchip',
		'cubic'
	};

	N = arrayfun(@(x) 2.^x, 1:14);
	H = arrayfun(@(x) 2./x, N);
	ErrVMF = zeros(length(funcs), length(intmethods));

	for fi = 1:length(funcs)
		G = linspace(-1, 1, 100000);
		Exact = funcs{fi}(G);
		Errors = zeros(length(intmethods), length(H));

		for mi = 1:length(intmethods)
			for ni = 1:length(N)
				X = linspace(-1, 1, N(ni));
				Sampled = funcs{fi}(X);
				Apprx = interp1(X, Sampled, G, intmethods{mi});

				errs = abs(Exact - Apprx);
				Errors(mi, ni) = max(errs);
			end
		end

		func = funcnames{fi}
		for mi = 1:length(intmethods)
			method = intmethods{mi}
			slope = polyfit(log(H), log(Errors(mi,:)), 1)(1)
			ErrVMF(fi, mi) = slope;
		end

		Errors = Errors;
		%loglog(H, Errors);
		%print(['q4plots/', funcnames{fi}, '.png'] , '-dpng');
	end

	ErrVMF = ErrVMF
end

q4();
