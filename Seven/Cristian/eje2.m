#! /usr/bin/octave -qf
1;
clear all;

function [s_k] = get_polos(N)
    
    techo = ceil(N/2);

    # for con N/2 pares, (N+1)/2 impares
    for k = 1 : techo
        alpha = (2*k - 1)/(2*N)*pi;
        s_k(k) = -sin(alpha) + j * cos(alpha);
        
        if (imag(s_k(k)) > eps)
            s_k(k + techo) = -sin(alpha) - j * cos(alpha);
        endif
        
    endfor
    
endfunction

# Creacion de filtro pasa-alto de Butterworth

# Definimos variables iniciales

wc = 500; # frecuencia de corte

fm = 2000;
Tm = 1 / fm;

t = 0 : Tm : 1 - Tm;

N = 3; # orden

##############

H_z = [];
polos = get_polos(N);

w_c = 2 / Tm * tan(pi * wc * Tm);

circulo = e.^(j * 2 * pi * t);

for i = 1 : length(circulo)
    
    z = circulo(i);
   
    s = 2/Tm * ((1 - z^-1)/(1 + z^-1));   
   
    ganancia = (w_c * s)^length(polos) / prod(-polos .* w_c);
   
    H_z(i) = ganancia / prod(s - w_c./(polos));    
        
endfor
