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
    
    antitransformada = antitransformada .* ventana';
    
    medio = floor(length(antitransformada) / 2);
    
    delta_orden = floor(orden/2);
    rango_central = medio - delta_orden : medio + delta_orden;

    tomar_central = antitransformada(rango_central);    
    tomar_central = [ zeros(1, medio - delta_orden - 1) tomar_central zeros(1, medio - delta_orden)];
    
    ret = tomar_central;      
    
    ret = fft(ret);

endfunction

# Tamano de ventana en muestras (Tm * msec)
ret = FIR(50, blackman(300));

plot(abs(ret));
