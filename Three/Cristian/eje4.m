#! /usr/bin/octave -qf
1;

# De la guia subida a internet

# Inicializamos seniales

ini = 0;
fin = 1;

fm = 100;
Tm = 1/fm;

n = ini : Tm : fin - Tm;
n2 = ini : Tm : fin*2 - Tm;

N = length(n);

f_cuad = 4;

cuadrada = sign(sin(2 * pi * f_cuad * n));

cuadrada_doble = [cuadrada zeros(1, N)];

df = fm/(N*2);

[fourier, frec] = get_fourier(cuadrada_doble, df, false);

desfase = 10;

desfasado = e.^(-j * ( 2 * pi * frec * desfase) / N);

desfasada = fourier .* desfasado;

cuadrada_desfasada = ifft(desfasada);

cuadrada_retardo = [sign(sin(2 * pi * f_cuad * n - desfase)) zeros(1,N)];

[fourier_retardo, frec_retardo] = get_fourier(cuadrada_retardo, df, false);

clf;

hold on;

stem(frec_retardo, angle(fourier_retardo), 'b');
stem(frec, angle(desfasada), 'r');

#stem(n2, abs(cuadrada_doble), 'k');
#stem(n2, abs(cuadrada_desfasada), 'r');
#stem(n2, abs(cuadrada_retardo), 'c');

hold off;

# Bueno no se que onda, el ploteo de la onda en dominio temporal se nota que 
# ambas estan desfasadas 10 muestras, pero enel dominio de la fase me da
# cualquier cosa :D.
