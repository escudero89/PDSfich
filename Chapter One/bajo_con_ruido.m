#! octave-interpreter-name -q -f # comment
function [ret] = bajo_con_ruido()
	[bajo, fs, bits] = wavread('bajo.wav');

	T = 1/fs;

	ini = 0;
	fin = length(bajo) * T;

	t = ini : T : fin - T;
	
	var_ruido = 0.1;
	ruido = -var_ruido + rand(1, length(t)) * (var_ruido * 2);
	bajo_con_ruido = bajo + ruido';

	% wavwrite(bajo_con_ruido, fs, 'bajo_con_ruido3.wav');

	potencia_senial = 1/length(t) * sum(bajo.^2)
	potencia_ruido = 1/length(t) * sum(ruido.^2)

	alpha = sqrt(potencia_senial / potencia_ruido);
	ruido_0db = ruido * alpha;
	
	alpha = sqrt(potencia_senial / ( potencia_ruido * 10^10 ));
	ruido_100db = ruido * alpha;
	
	potencia_ruido_0db = 1/length(t) * sum(ruido_0db.^2)
	potencia_ruido_100db = 1/length(t) * sum(ruido_100db.^2)
	
	ret = 10 * log10(potencia_senial / potencia_ruido_100db);
	
 	% plot(t(1:50:length(t)), ruido_0db(1:50:length(t)), 'r', t(1:50:length(t)), bajo(1:50:length(t)),'g')
endfunction