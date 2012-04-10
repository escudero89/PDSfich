a = 1;

function [ret] = escalon(t)
	for i = 1 : length(t)
		if t(i) < 0
			ret(i) = -1;
		else
			ret(i) = 1;
		end
	end
endfunction

function [ret] = apr_tres(t, a1, a3)
	for i = 1 : length(t)
		ret(i) = a1 * (sqrt(3/2)*t(i)) + \
		         a3 * (sqrt(7/2)*((5/2)*t(i)^3 - (3/2)*t(i)));
	end
endfunction

T = 1/1000;
t = -1 : T : 1-T;

y = escalon(t);

alpha1 = sqrt(3/2);
alpha3 = - sqrt(7/32);

ind = 1;
for i = 0.7 : 0.05 : 1.3
	for j = 0.7 : 0.05 : 1.3
		a1 = i*alpha1;
		a3 = j*alpha3;
		y_apr_tres = apr_tres(t, a1, a3);
		error_cuadratico_tres = norm(y - y_apr_tres, 2)^2;
		x(ind) = a1;
		yy(ind) = a3;
		z(ind) = error_cuadratico_tres;
		ind = ind + 1;
	end
end

plot3(x, yy, z);