#! /usr/bin/octave -qf
1;
clear all;
clf;

# Funcion auxiliar -> grados a radianes

function [radian] = d2r (degree)
    radian = degree*pi/180;
endfunction 

# De polares a complejos, sin R => R * (cos(theta) + j sen(theta))
function [arg] = p2c(R = 1, degree = 0)
    radian = d2r(degree);
    arg = R * (cos(radian) + j * sin(radian));
endfunction

# Valores iniciales

ceros = [
    p2c(0.80, 30);
    p2c(0.80, 60);
    p2c(0.80, -30);
    p2c(0.80, -60);
];

r_polos = 0.95; # para el inciso d
polos = [
    p2c(r_polos, 45);
    p2c(r_polos, 45);
    p2c(r_polos, -45);
    p2c(r_polos, -45);
];

#plot(e.^(j*[0:0.01:2*pi]),'g',ceros,'xr',polos,'xb')

# Inciso b

ini = 0;
fin = 1;
fm = 200;
T = 1/fm;

t = ini : T : fin - T;
N = length(t);

z = e.^(j * t * 2 * pi);

for n = 1 : N
    
    for k = 1 : length(ceros)
        numerador(k) = z(n) - ceros(k);
    endfor

    for k = 1 : length(polos)
        denominador(k) = z(n) - polos(k);
    endfor
    
    H(n) = prod(numerador) / prod(denominador);

endfor

# Inciso c

H_norm = H / max(H); # Se hara asi?

# Inciso e

w = 2 * pi * t;
f1 = 15;
f2 = 25; 

sins = sin(w .* f1) + sin(w .* f2);

f_sins = fft(sins);
c_sins = ifft(abs(H_norm .* f_sins));

plot(t, sins, 'g', t, c_sins, 'r');
