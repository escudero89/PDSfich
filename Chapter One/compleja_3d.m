function [t, y_out, i_out] = compleja_3d(ini, fin, paso)
	t = ini : paso : fin - paso;
	
	vec = e.^(i*t);
	y_out = real(vec);
	i_out = imag(vec);
endfunction
