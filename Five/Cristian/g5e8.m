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

fourier = ifft(abs(1./fft(fid)));

x_n_d = conv(y_n, abs(fourier));

clf;

hold on;

stem(x_n, 'k');
stem(x_n_d, 'r');
stem(y_n, 'g');

hold off;
