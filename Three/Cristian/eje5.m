#! /usr/bin/octave -qf
1;
clear all;

# De la guia subida a internet
# Inicializamos variables

ini = -1;
fin = 1;

ini_ventana = 0;
fin_ventana = 1;

fm = 25;
Tm = 1/fm;

n = ini : Tm : fin - Tm;
N = length(n);

# Senial base
A = 3;
f_sen = 10;

w = 2 * pi * n;

senoidal = A * sin(w * f_sen);

for muestra = 1 : N    
    
    omega = 2 * pi * muestra;
    
    # Ventana cuadrada
    w_R(muestra) = 1;

    # Ventana de Hanning
    w_h(muestra) = 1/2 - 1/2 * cos(omega / N);

    # Ventana de Hamming
    w_H(muestra) = 27/50 - 23/50 * cos(omega / N);
    
    # Ventana de Barlett
    
    if (muestra < N/2)
        asignar = 2 * muestra / N;
    else 
        asignar = 2 - 2 * muestra / N;
    endif   
    
    w_B(muestra) = asignar;
    
    # Ventana de Blackman
    
    w_K(muestra) = 21/50 - 1/2 * cos(omega/N) + 2/25 * cos(2 * omega / N);
    
endfor

#################
# Hora de Fourier

dF = fm / N;

[w_R_fou, frec] = get_fourier(senoidal .* w_R, dF);
[w_h_fou, frec] = get_fourier(senoidal .* w_h, dF);
[w_H_fou, frec] = get_fourier(senoidal .* w_H, dF);
[w_B_fou, frec] = get_fourier(senoidal .* w_B, dF);
[w_K_fou, frec] = get_fourier(senoidal .* w_K, dF);

#########
# GRAFICO 
y_coord = ones(1, N);

fourier = true;

clf;
hold on;

if (fourier == false)
    plot3(n, y_coord * 0, senoidal .* w_R, 'k');
    plot3(n, y_coord * 1, senoidal .* w_h, 'r');
    plot3(n, y_coord * 2, senoidal .* w_H, 'g');
    plot3(n, y_coord * 3, senoidal .* w_B, 'b');
    plot3(n, y_coord * 4, senoidal .* w_K, 'c');
else
    stem3(frec, y_coord * 0, abs(w_R_fou)/N, 'k');
    stem3(frec, y_coord * 1, abs(w_h_fou)/N, 'r');
    stem3(frec, y_coord * 2, abs(w_H_fou)/N, 'g');
    stem3(frec, y_coord * 3, abs(w_B_fou)/N, 'b');    
    stem3(frec, y_coord * 4, abs(w_K_fou)/N, 'c');    
endif

hold off;
