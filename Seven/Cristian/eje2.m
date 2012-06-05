#! /usr/bin/octave -qf
1;
clear all;

function [s_k] = get_polos(N)
    
    d = 1e-6;
    techo = ceil(N/2);

    # for con N/2 pares, (N+1)/2 impares
    for k = 1 : techo
        alpha = (2*k - 1)/(2*N)*pi;
        s_k(k) = -sin(alpha) + j * cos(alpha);
        
        if (imag(s_k(k)) > d)
            s_k(k + techo) = -sin(alpha) - j * cos(alpha);
        endif
        
    endfor
    
endfunction

# Creacion de filtro pasa-alto de Butterworth

# Definimos variables iniciales

w_c = 500; # frecuencia de corte

fm = 2000;
Tm = 1 / fm;

t = 0 : Tm : 1 - Tm;

N = 3; # orden

##############3

H_z = [];
polos = get_polos(N);

circulo = e.^(j*2*pi*t);

for i = 1 : length(circulo)
    
    z = circulo(i);    
   
    s = 2/Tm * ((1 - z^-1)/(1 + z^-1));
   
    H_z(i) = 1 / prod(s - polos);    
        
endfor
