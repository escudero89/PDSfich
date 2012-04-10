a=1;

function [ret] = escalon(t)
	for i = 1 : length(t)
		if t(i) < 0
			ret(i) = -1;
		else
			ret(i) = 1;
		end
	end
endfunction

function [ret] = apr_tres(t)
	for i = 1 : length(t)
		ret(i) = (45/16)*t(i) - (35/16)*t(i)^3;
	end
endfunction

function [ret] = apr_cinco(t, a1, a3, a5)
	for i = 1 : length(t)
		ret(i) = a1 * (sqrt(3/2)*t(i)) + \
		         a3 * (sqrt(7/2)*((5/2)*t(i)^3 - (3/2)*t(i))) + \
				 a5 * (sqrt(11/128) * (15*t(i) - 70*t(i)^3 + 63*t(i)^5));
	end
endfunction

T = 1/1000;
t = -1 : T : 1-T;

y = escalon(t);
y_apr_tres = apr_tres(t);

error_cuadratico_tres = norm(y - y_apr_tres, 2)^2

y_apr_cinco = apr_cinco(t, sqrt(3/2), - sqrt(7/32), sqrt(11/128));
error_cuadratico_cinco = norm(y - y_apr_cinco, 2)^2

plot(t, y, 'k', t, y_apr_tres, 'r', t, y_apr_cinco, 'g');