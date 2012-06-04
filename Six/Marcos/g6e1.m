1;
n = 100;
dirac =[1 zeros(1,n-3)];
condIniX = [0 0];
y = [0 0];
dirac = [condIniX dirac];

for i = 3:n
	y(i) = 2 * dirac(i) - 1/10 * y(i-1) + 1/2 * y(i-2) - 3 * dirac(i-2);
endfor
% Obtenemos la respuesta en frecuencia como la fft de la respuesta al impulso
%stem(y);
Y = fft(y);
%stem(abs(Y));

%% Otra forma de obtener la respuesta en frecuencia como la evaluación en 
%% z = e^(wj) de la funcion de transferencia


%z = -5 -5i:0.01+0.01i:5+5i;
%z = imag(z);
w = -1:0.01:1;
z = e.^(w .* i);
%
H = (2 * z.^2 - 3) ./ (z.^2 + 0.1 * z - 0.5);

%r = real(z);
%im = imag(z);
stem(H);


