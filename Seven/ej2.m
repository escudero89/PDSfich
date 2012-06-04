1;

function [ret] = pa_butterworth(polos, fc, fm)
	T = 1/fm;
	N = length(polos);
	
	circulo = e.^(j*[ -pi/6 : T : pi/6 ]);
	
	for i = 1 : length(circulo)
		z = circulo(i);
		bilineal = 2/T * (1 - z^-1)/(1 + z^-1);
		ret(i) = 1;
		bilineal
		for r = 1 : N
			ret(i) = ret(i) * (1/bilineal - polos(r));
		endfor
		
		ret(i) = 1/ret(i);
	end
endfunction

function [n_polos, n_ceros, n_ganancia] = pb_pa(polos, ceros, ganancia)
	n_polos = [];
	n_ceros = [];
	n_ganancia = 1;
	for i = 1 : length(polos)
		n_ceros = [n_ceros 0];
		n_polos = [n_polos -1/polos(i)];
		n_ganancia *= (-1/polos(i));
	end
endfunction

function [rf] = bilineal(polos, ceros, ganancia, fm, z)
	T = 1/fm;
	circulo = e.^(j*[-pi/2 : T : pi/2-T]);
	rf = 1;
	for p = polos
		rf /= ((2/T)*(1-z^-1)/(1+z^-1)) - p;
	end
	for c = ceros
		rf *= ((2/T)*(1-z^-1)/(1+z^-1)) - c;
	end
	rf *= ganancia;
endfunction

N = 4;
fc = 500;

for k = 0 : N - 1
	polos(k + 1) = fc * pi * e^(j*pi/2) * e^(j*(2*k + 1)*pi/(2*N));
endfor

%rf = pa_butterworth(polos, fc*pi, 2000);