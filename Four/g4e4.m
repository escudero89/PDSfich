1;
X = [0 0 0 0 0 0 0 1 2 3 2 2 1 0 0 0 0 0 0 0]; 
n = 1 : length(X);
N = length(n);
% Sistema 1;
Y1 = X; % lineal

% Sistema 2;
Y2 = X + 2; % no lineal

% Sistema 3;
Y3 = [ X(1) X(2) ];

for j=3:N
	Y3(j) = X(j) + 0.5 * Y3(j-1) + 0.25 * Y3(j-2);
endfor


punto='a';

clf;
hold on;
if (punto == 'a')
	%En este caso verificamos el cumplimiento de la propiedad que dice que si el
	%sistema es lineal, entonces la salida es 0 cuando la entrada es 0
	#plot(n, Y1, 'b');
	stem(n, Y3, 'g');
	stem(n, X, 'r');
else
	plot(n, abs(fft(Y2))/length(n), 'r');
	stem(n, abs(fft(Y1))/length(n), 'b');
endif
hold off;