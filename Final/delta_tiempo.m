#! /usr/bin/octave -qf

function [dt] = delta_tiempo( h1, h2, s, fm = 0 )

    h1 = check_signal(h1);
    h2 = check_signal(h2);
    s = check_signal(s);
    
    s1 = conv(h1, s);
    s2 = conv(h2, s);
    
    # Correlacionamos usando una funcion incluida en el paquete "octave-signal"
    [R, lag] = xcorr(s1, s2);
    
    # Buscamos la maxima energia, y buscamos en el mismo indice al lag
    [m, idx] = max(R);
    
    dt = lag(idx);
    
    # Si le pasamos fm, devolvemos el dT en segundos (sino en muestras)
    if (fm)
        dt *= 1/fm;
    endif
    
    return;

endfunction


# Chequea si le paso una senial como un string (para cargarlo desde un archivo)

function [ret] = check_signal( s )

    if (ischar(s))    
        ret = load(s);    
    else 
        ret = s;         
    endif
    
    return;

endfunction
