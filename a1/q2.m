% question 2 wrapper
function ans = q2() 
	no_pow = 16;
	degs = [2, 7, 16];
	hs = arrayfun( @(x) (4/3)^(-x), 1:no_pow);
	fs = {@(x) sign(x), @(x) sin(x), @(x) abs(x), @(x) x.^5};
	names = {'sign', 'sin', 'abs', 'quintic'};

	for k = 1:length(fs)
		errors = zeros(length(degs),no_pow);
		for j = 1:length(degs)
			for i = 1:no_pow
				h = hs(i);
				deg = degs(j);
				[G, Exact, Apprx, errors(j, i)] = test_lagrange(h*8, deg, fs{k} );
%				[~, ~, ~, errors(j, i)] = test_lagrange(h*32, deg, fs{k} );

%				if k==3
%					h=h
%					deg=deg
%					name=names{k}
%					G=G
%					plot(G, Exact, G, Apprx)
%					print -dpng /dev/null
%				end
			end	
		end

		name=names{k}
		for j=1:length(degs)
			slope = polyfit(log(hs), log(errors(j, :)), 1)(1)
		end
		errvh = zeros(length(hs), 1+length(degs));
		errvh(:, 1) = hs';
		errvh(:, 2:(length(degs)+1)) = errors'


		loglog(hs, errors)
		print(["q2plots/", names{k}, ".png"], "-dpng");
	end

	ans = 0
end

q2();
