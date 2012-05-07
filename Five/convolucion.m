function [y] = convolucion(x1, x2)
	n1 = length(x1);
	n2 = length(x2);
	for i = 1 : (n1+n2-1)
		y(i) = 0;
		for j = 1 : n1
			y(i) += evaluar(x1,j)*evaluar(x2, i-j+1);
		end
	end
endfunction