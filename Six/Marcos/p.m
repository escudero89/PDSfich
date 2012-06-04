1;

% Muestras
	n = 100;

% Impulso
	I = [0 0 1 zeros(1,n-3)];

% Respuesta al impulso de Sistema
	y = [0 0];
	for j = 3:n
	%y(j) = 0.5 * y(j-1) - 0.25 * y(j-2) + I(j); %SISTEMA ESTABLE
	y(j) = 2 * I(j) - 0.1 * y(j-1) + 0.5 * y(j-2) - 3*I(j-2); % SISTEMA INESTABLE
	endfor



% Respuesta en frecuencia por TRANSFORMADA DE FOURIER
	Y1 = fft(y);
	stem(fftshift(abs(Y1)));

% Respuesta en frecuencia por FUNCION DE TRANSFERENCIA
	
	% Funcion de Transferencia de Sistema evaluada en z = e^(jw)
			w = 0:1/n:2*pi-1/n;
			z = e.^(w*(0+1i));
			%H = z.^2 ./ (z.^2 - 0.5*z + 0.25); %SISTEMA ESTABLE
			H = (2 * z.^2 - 3)./(z.^2 + 0.1*z -0.5); %SISTEMA INESTABLE
			%plot(abs(H));

 h = ifft(H);

