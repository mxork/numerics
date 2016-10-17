function unused = graphplot(filename, G, Ys, Labels={})
	clf;
	plot(G, Ys);

	% thanks, internet
	FS = findall('-property','FontSize');
	set(FS,'FontSize',6);

	if length(Labels) > 0
		legend(Labels, 'location', 'eastoutside');
	end

	print(filename, '-dpng');
end
