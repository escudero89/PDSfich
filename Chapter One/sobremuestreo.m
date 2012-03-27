function [t, y_out] = sobremuestreo(y, ini, fin, fm0, fm) 
% Prop es la proporcion entre la fm antigua y la nueva
	T0 = 1/fm0;
	T = 1/fm;
	
	t0 = ini : T0 : fin - T0;
	t = ini : T : fin - T;
	
	y_out = zeros(1, length(t));
	
	for n = 1 : length(t0)
		% Esto t/T0 - n + 1 es analogo a ((t-n*T0)/T0)
		y_out += y(n) * sinc(t/T0 - n + 1);
	end
	
	plot(t0, y, 'r', t, y_out, 'g');
	
endfunction

function [y_out] = i_escalon(t)
	y_out = zeros(1, length(t));
	
	for j = 1 : length(t)
		if (t(j) >= 0 & t(j) < 1)
			y_out(j) = 1;
		end
	end
endfunction

function [y_out] = i_lineal(t)
	y_out = zeros(1, length(t));
	
	for j = 1 : length(t)
		if abs(t(j)) < 1
			y_out(j) = 1 - abs(t(j));
		end
	end
endfunction