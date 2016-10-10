function unused = q4()
	funcs = {
		@(x) sign(x),
		@(x) sin(x),
		@(x) abs(x),
		@(x) x.^5,
		@(x) (1+25.*x.^2).^(-1)
	}

	intmethods = {
		"nearest",
		"linear",
		"parabolic",
		"spline",
		"pchip",
		"cubic"
	}

	G = linspace(-1,1, 1000);
	N = arrayfun(@(x) 2.^x, 1:6)
	H = arrayfun(@(x) 2./x, N)

	for fi = 1:length(funcs)
		for mi = 1:length(intmethods)
			for ni = 1:length(N)
				Exact = funcs{fi}(G)
				X = linspace(-1, 1, N)
				Sampled = funcs{fi}(X
				Apprx = interp1(X, Sampled, G, intmethods(mi))

				Errors = abs(Exact .- Apprx)
			end
		end
	end
end
