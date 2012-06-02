function [ret] = correlacion (x, y)
	ny = length(y);
	ret = conv(x, y(ny : -1 : 1));
endfunction
