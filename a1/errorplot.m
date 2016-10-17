function unused = errorplot(filename, H, Errs, Labels={})
	clf;
	loglog(H, Errs);

	% thanks, internet
	FS = findall('-property','FontSize');
	set(FS,'FontSize',6);

	if length(Labels) > 0
		legend('boxoff');
		legend(Labels, 'location', 'eastoutside');
	end

	print(filename, '-dpng');
end
