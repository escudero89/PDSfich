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

ini = -10;
fin = 100;

t = ini : fin;
n = 1 : length(t);

x_n = (t == 0); # delta de dirac

# Paso por el sistema A, convoluciono entonces

ha_n = (1/2).^n .* step(t, true);

y_A = conv(x_n, ha_n);

# Paso por el sistema B, que da como salida...

n_A = 1 : length(y_A);

y_B = n_A .* y_A;


### Procedo a hacer la inversa

y_B_inv = n .* ha_n;

y_inv = conv(y_B_inv, x_n);

clf;
hold on;
plot(y_B, 'r');
stem(y_inv, 'g');
hold off;
