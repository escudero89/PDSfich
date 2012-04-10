function [est, ergo] = est_ergo(M, tolv = 1e-1, tolm = 1e-4)
	
	[m, n] = size(M);
	
	col_means = mean(M);
	row_means = mean(M');
	
	est = (var(col_means) < tolv);
	if est
		mean_cm = mean(col_means);
		mean_rm = mean(row_means);
		ergo = (var(row_means) < tolv) & (abs(mean_cm - mean_rm) < tolm);
	end
endfunction