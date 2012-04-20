#! /usr/bin/octave -qf
1;

# De la guia subida a internet

# Inicializamos seniales

ini = 0;
fin = 1;

fm = 100;
Tm = 1/fm;

n = ini : Tm : fin - Tm;
N = length(n);

f_cuad = 4;

cuadrada = sign(sin(2 * pi * f_cuad * n));

cuadrada_doble = [cuadrada zeros(1, N)];

df = fm/(N*2);

[fourier, frec] = get_fourier(cuadrada_doble, df, false);

# Desfasamos multiplicando por e^-j2pik/N la trasnformada

n2 = [ini : Tm : 2 - Tm];
N2 = length(n2);

desfase = 10;
desfasada = fourier .* e.^(-j * 2 * pi * desfase * frec / N2);

transf_desfasada = ifft(desfasada);

# Generamos la misma senial pero retardada 10 muestras

cuadrada_ret = [ sign(sin(2 * pi * f_cuad * n - desfase)), zeros(1, N)];

# Obtengo la fourier desfasada

[fourier_ret, frec_ret] = get_fourier(abs(cuadrada_ret), df, false);

clf;

hold on;
#stem(frec, angle(fourier), 'r');
#stem(frec_2, angle(fourier_2), 'c');
#stem(n2, cuadrada_doble, 'k');
stem(n2, real(transf_desfasada), 'r');
stem(n2, cuadrada_ret, 'b');
hold off;
