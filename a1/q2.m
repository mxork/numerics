% question 2 wrapper
function ans = q2() 
	no_pow = 6;
	degs = [2, 7, 16];
	hs = arrayfun( @(x) 10^(-x), 1:no_pow);
	fs = {@(x) sign(x), @(x) sin(x), @(x) abs(x), @(x) x.^5};
	names = {"sign", "sin", "abs", "quintic"};

	for k = 1:length(fs)
		errors = zeros(length(degs),no_pow);
		for j = 1:length(degs)
			for i = 1:no_pow
				h = hs(i);
				deg = degs(j);
				[~, ~, ~, errors(j, i)] = test_lagrange(h*100*pi, deg, fs{k} );
			end	
		end
		errors;
		loglog(hs, errors)
		print(["plots/", names{k}, ".png"], "-dpng");
	end

	ans = 0
end

q2();
