#! /usr/bin/octave -qf
1;
clear all;

function [ret] = FIR(orden, ventana)

    # Muestreo la frecuencia deseada

    fm = 300;

    f_ruido = 50;
    delta_ruido = 2;
    rechazo = f_ruido - delta_ruido : f_ruido + delta_ruido;

    resp_frec = ones(1, fm);    
    resp_frec(rechazo) = 0;
    
    # Tomo la IFFT
    
    antitransformada = ifftshift(real(ifft(resp_frec)));    
    
    # Tomo la N+1 muestras centrales   
    
    ret = antitransformada .* ventana';
    
    ret = fft(ret);

endfunction

# Tamano de ventana en muestras (Tm * msec)
ret = FIR(50, blackman(300));

plot(abs(ret));
