#! /usr/bin/octave -qf

# Le paso una senial y Df, la devuelve acomodada y con la correcta frecuencia.

function [fourier, frec] = get_fourier(senial, delta_f)

    N = length(senial);
    
    frec = [0 : N-1] * delta_f;
    
    fourier = fft(senial);
    
    frec = fftshift(frec);
    fourier = fftshift(fourier);
    
    # La frec me va a quedar algo asi [..., N-2, N-1, 0, 1, 2, ...]
    # Y yo quiero algo asi [..., -2, -1, 0, 1, 2, ...], por lo que restamos N
    # hasta que llegamos a cero
    
    for i = 1 : length(frec)
    
        if (frec(i) == 0)
            break;
        endif
        
        frec(i) -= N;
    
    endfor
        
endfunction
