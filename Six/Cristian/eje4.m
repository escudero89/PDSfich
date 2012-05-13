#! /usr/bin/octave -qf
1;

clear all;

# Transformacion de Euler
function [ret] = trans_euler(X, T, Y = [0 0 0])

    R1 = 1100;
    C2 = 1e-6;
    R3 = 2200;
    C4 = 2e-6;
    R5 = 1000;


    N = length(X);
    
    for n = 3 : N

        # Mega alta ecuacion sacada de Maxima4.wmx

        Y(n) = ((((X(n) + Y(n - 1) - X(n - 1)) * C4 + (X(n)         \
            - X(n - 1)) * C2) * R5 + Y(n - 1) * C4 * R3             \
            + (Y(n - 1) * C4 + Y(n - 1) * C2) * R1) * T             \
            + (X(n) - 2 * X(n - 1) + X(n - 2)) * C2 * C4 * R5^2     \ 
            + ((X(n) - 2 * X(n - 1) + X(n - 2)) * C2 * C4 * R3      \
            + (2 * Y(n - 1) - Y(n - 2)) * C2 * C4 * R1) * R5        \
            + (2 * Y(n - 1) - Y(n - 2)) * C2 * C4 * R1 * R3)        \
            / (T^2 + (C4 * R5 + C4 * R3 + (C4 + C2) * R1) * T       \
                + C2 * C4 * R1 * R5 + C2 * C4 * R1 * R3);
    
    endfor
                
    ret = Y;                
    
endfunction

# Valores iniciales

ini = -0.1;
fin = 1;

fm = 100;
Tm = 1/fm;

t = ini : Tm : fin - Tm;
N = length(t);

dirac = (abs(t) < 1e-13);

# Probamos con un impulso y obtenemos la respuesta del sistema

H = trans_euler(dirac, Tm);

# Hasta el indice 11 son ceros, por lo que no lo uso para convolucionar

H_c = H(11 : length(H));

# Ingresamos una fuente alterna de 10Hz y 1V aprox por 0.5 segundos

V = 1;
f = 10;

Ei = (t >= 0 & t <= 0.5) .* ( V * sin(2 * pi * f * t));

convolucion = conv(Ei, H_c);

clf;
hold on;

stem(t, Ei, 'b');
stem(t, trans_euler(Ei, Tm), 'g');
stem(t, H, 'k');
plot(t, convolucion(1:N), 'r');

hold off;
