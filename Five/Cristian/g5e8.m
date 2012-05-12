#! /usr/bin/octave -qf
1;
clear all;

# Leo el archivo

fid = load("pb100.txt");

fid = fid';

# Creo las cinco senales senoidales

f = [ 50 75 100 125 150 ];

ini = 0;
fin = 1;
fm = 1000;
T = 1/fm;

t = ini : T : fin - T;

sins = sin(2 * pi * f' * t); # en cada fila tengo una senal

x_n = sum(sins);

# Convolucionamos

y_n = conv(x_n, fid);

# Deconvolucionamos

fourier = fft(fid);
y_n_fou = fft(y_n);

fourier = abs(fourier);
N_f = round(length(fourier) / 2);
fourier = [ fourier(1 : N_f - 1)  zeros(1, abs(length(fourier) - length(y_n_fou))) fourier(N_f : length(fourier)) ];

x_n_d = abs(ifft(abs(y_n_fou) ./ fourier));

clf;

hold on;

stem(x_n, 'k');
stem(y_n, 'g');
plot(x_n_d, 'r');

hold off;
