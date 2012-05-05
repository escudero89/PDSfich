#! /usr/bin/octave -qf
1;

function [Y] = set_response(X)
# 6y[n] - 4y[n-1] + 5y[n-2] = x[n] - 2 x[n-1] + x[n-2]
# y[n] = 1/6 x[n] - 1/3 x[n-1] + 1/6 x[n-2] + 2/3 y[n-1] - 5/6 y[n-2]

    Y = [ 0 0 0 ];

    for n = 3 : length(X)
        Y(n) = 1/6 * X(n) - 1/3 * X(n - 1) + 1/6 * X(n - 2) + 2/3 * Y(n - 1) - 5/6 * Y(n - 2);
    endfor    

endfunction

# Inicializamos variables

ini = -200;
fin = 200;

t = ini : fin;
N = round(length(t) / 2);

# Funciones step y dirac
step = [zeros(1, N) ones(1, N - 1)];
dirac = [zeros(1, N - 1) 1 zeros(1, N - 1)];

# Senial a comparar
Y = set_response(step);
Y_dirac = set_response(dirac);

# Ploteamos
escala = 1/100;

des = ones(1, length(t)) * escala;

big_t = ini*2 : fin*2;
big_des = ones(1, length(big_t)) * escala;

clf;
hold on;
    plot3(t, des * 0, X, 'b');
    stem3(t, des * 1, Y, 'g');
    stem3(t, des * 2, Y_dirac, 'r');    
    
    # La onda es que asume periodicidad, por eso sale asi
    stem3(big_t, big_des * 3, conv(X, Y_dirac), 'c');
    stem3(big_t, big_des * 4, convolucion(X, Y_dirac), 'm');
hold off;
