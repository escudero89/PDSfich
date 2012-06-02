#! /usr/bin/octave -qf
1;
clear all;
clf;

# Creacion de filtro pasa-alto de Butterworth

# Definimos variables iniciales

w_c = 500; # frecuencia de corte

fm = 2000;
Tm = 1 / fm;

t = 0 : Tm : 1 - Tm;

N = 6; # orden

k = [ 1 : N ];

# Formula para determinar polos de Butterworth:
s_k = w_c^(-1/N) * e.^(j * (2 * k + N - 1) * pi / (2 * N));

# Pero me tengo que quedar con los del lado izquierdo
s_left = [];
for m = 1 : N
    if !(real(s_k(m)) > 0)
        s_left = [s_left s_k(m)];
    endif
endfor

z_c = e.^(j*t*pi);

s = (1 - z_c) ./ (1 + z_c);

for m = 1 : length(s)
    H_z(m) = 1 ./ prod(s(m) - s_left);
endfor

plot(abs(H_z));
