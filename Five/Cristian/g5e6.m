#! /usr/bin/octave -qf
1;

function [X] = set_response(t, alfa = 1)

    X = [ 0 0 ];
    dirac = t == 0; # [-2 -1 0 1 2 ] => [ 0 0 1 0 0 ]

    for n = 2 : length(dirac)
    
        X(n) = dirac(n) - alfa * dirac(n - 1);
    endfor    

endfunction

# Inicializamos variables

ini = -200;
fin = 200;

t = ini : fin;
n = 1 : length(t);

ha_n = sin(8 * t);

alfa = .9; # |alfa| < 1
hb_n = alfa.^n .* step(t, true);

x_n = set_response(t);

y_n = convolucion(x_n, convolucion(ha_n, hb_n));

clf;

hold on;

plot(-600:600, y_n, 'g');

hold off;
