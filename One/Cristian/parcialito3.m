1;

# Escriba el código que permita generar una señal cuadrada periódica de 
# frecuencia dada, con valores entre -1 y 1. La función debe ser llamada con los 
# siguientes parámetros x=cuadrada(f,t,fm), donde f es la frecuencia de la señal,
# t es la duración y fm es la frecuencia de muestreo. Luego genera una señal 
# cuadrada de 2 segundos muestreada a 50 Hz, con frecuencia 5 Hz y contamínela 
# con ruido gaussiano a una SNR de 10 dB.

function [x] = cuadrada(f, t, fm)
    T = 1/fm;    
    tiempo = 0 : T : t - T;
    
    x = sign(sin(2*pi*f*tiempo));
endfunction

function [ret] = get_potencia(x)
    ret = sum(x.^2)/length(x);
endfunction

fm = 50;
t = 5;
T = 1/fm;    
tiempo = 0 : T : t - T;

Y_cuadrada = cuadrada(5,t,fm);
Y_ruido = randn(1, length(tiempo));

pot_cuadrada = get_potencia(Y_cuadrada)
pot_ruido = get_potencia(Y_ruido);

B = 10; # en db

alpha = sqrt(pot_cuadrada / pot_ruido * 10^(-B/10));

Y_ruido_nuevo = Y_ruido * alpha;

get_potencia(Y_ruido_nuevo)

plot(tiempo, Y_cuadrada, 'g', tiempo, Y_ruido_nuevo, 'r');
