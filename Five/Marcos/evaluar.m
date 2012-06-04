function [y] = evaluar(a, i)
	if i < 1 | i > length(a)
		y = 0;
	else
		y = a(i);
	end
endfunction