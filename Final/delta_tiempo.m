#! /usr/bin/octave -qf

# Le podes pasar h1, h2, s y fm como seniales aparte, o llamarla con nombres
# de archivos y lo hace automaticamente:
# delta_tiempo ("archivo.mat", "sonido.wav")

function [dt] = delta_tiempo( h1, h2 = [], s = [], fm = 0 )

    [ h, check ] = check_signal(h1);
    
    if (check)
        h1 = h.data(:, 1)';
        h2 = h.data(:, 2)';
        fm = h.Fs;
        
        s = check_signal(h2);
    endif
        
    s1 = conv(h1, s);
    s2 = conv(h2, s);
    
    # Correlacionamos usando una funcion incluida en el paquete "octave-signal"
    [R, lag] = xcorr(s1, s2);
    
    # Buscamos la maxima energia, y buscamos en el mismo indice al lag
    [m, idx] = max(R);
    
    dt = lag(idx);
    
    # Si tenemos fm, devolvemos el dT en espacio recorrido (sino en muestras)
    sound_speed = 343;
    
    if (fm)
        dt *= 1/fm * sound_speed;
    endif
    
    return;

endfunction


# Chequea si le paso una senial como un string (para cargarlo desde un archivo)

function [ ret, check ] = check_signal( s )

    if (ischar(s))
    
        if (findstr(s, "mat")) # es .mat o .wav?
            ret = load(s);
        else
            ret = wavread(s);
        endif
        
        check = true;          
    else 
        ret = s;
        check = false;   
    endif
    
    return;

endfunction
