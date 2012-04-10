function [t_out, y_out] = aleatoria_gauss(ini, fin, f, cant = 1)
	T = 1/f;
	t_out = ini : T : fin - T;
	y_out = 10 + 5 * randn(cant, length(t_out));
endfunction