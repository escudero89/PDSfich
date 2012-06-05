#! /usr/bin/octave -qf
1;
clear all;

# De la guia subida a internet

# Obtengo una senoidal de la forma del eje7 ya transformada
# Le paso la duracion (ms), la fm, y las frecuencias

function [fourier, frec] = get_senoidal(T, fm, f1, f2)
    
    T = T / 1000; # para pasarlo a segundos
    
    Tm = 1/fm;
    t = 0 : Tm : T - Tm;
    
    omega = 2 * pi * t;
    
    senoidal = sin(omega * f1) + 4 * sin(omega * f2);      
    
    dF = fm / length(t);
    
    [fourier, frec] = get_fourier(senoidal, dF);

endfunction

# Una matriz con T (ms), fm, f1, f2

matriz_datos = [
    249, 512, 112, 200 ; # Este da si ses divide por el factor de prop 4
    498, 128, 56,  200 ; # Me fallan las frecuencias y el N
    993, 128, 100,  50 ; # Este puede ser :D
    498, 256, 56,  868 ; # Descartado :/. No me convence
    993, 128, 100,  78 ; # Aprobado, aunque con aliasing
  124.5,1024,3872,5520]; # Este da si se divide por el factor de prop 8

# Cantidad de filas
N = size(matriz_datos)(1);

# Colores
color = [ "k", "r", "g", "b", "c", "m" ];

# plotear ALL the things!
clf;
hold on;

for m = 1 : N 
    
    args = matriz_datos(m, :);
    
    [fourier, frec] = get_senoidal(args(1), args(2), args(3), args(4));
    
    stem3(frec, ones(1, length(frec)) * m, abs(fourier), color(m));
    
endfor

hold off;


