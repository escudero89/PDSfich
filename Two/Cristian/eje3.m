#! /usr/bin/octave -qf
1;

# El producto interno de seniales de distinta frecuencia me da cero (o cercano),
# como bien deberia ser. Parece haber algun error loco cuando trata con frecuencias
# de muestreo y con frecuencias altas o muy bajas.
# Probar esto variando la frecuencia de muestreo entre 100 ~ 300 Hz.

frec = [0.2 1.5 3 5 9 20 100];

ini = -3;
fin = 3;
fm = 200;
T = 1/fm;

t = ini : T : fin - T;

sin_base = sin(2*pi*t); # frecuencia de onda 1

sins = zeros(length(frec), length(t));

for j = 1 : length(frec)
    sins(j, :) = sin(2*pi*frec(j)*t);
    
    dots(j) = dot(sin_base, sins(j, :))/dot(sins(j, :), sins(j, :));
endfor

bar(dots);
