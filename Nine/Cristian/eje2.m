#! /usr/bin/octave -qf
1;
clear all;

# Calcula la cantidad de veces que la grafica corta al eje x
function [corta] = count_cortes(S)

    corta = 0;
    
    signo = sign(S);
    banda = signo(1);
    
    for l = 2 : length(S)
        
        if (signo(l))
            if (banda != 0 && (banda == signo(l)*-1))
                corta += 1;
                banda = signo(l);
            else                 
                banda = signo(l);
            endif
        endif
    
    endfor
   
    return;

endfunction

# Le paso el pitch en muestras, y la fm, y me retorna su valor en hertz
# Suponiendo que las muestras estaban en el dominio temporal
function [pitch] = get_pitch_hertz(old_pitch, fm)

    pitch = 1 / (old_pitch * 1 / fm);
    
    # Si el pitch esta fuera del rango humano (50 ~ 400 Hz), devolvemos cero
    minfrec = 100;
    maxfrec = 400;
    
    if ( pitch > maxfrec || pitch < minfrec )
        pitch = 0;
    endif

    return;

endfunction

# Le pasas una senal y su frec de muestre, y devuelve el segundo pico mas alto (pitch)
# y la autocorrelacion

function [ pitch ] = pitch_autocorr(S, fm)

    [ autocorr, lag ] = xcorr(S);
    
    # Cuento la cantidad de muestras que quedan en cero

    m_ceros = runlength(lag >= 0)(1);
    
    # Nos quedamos con el lado derecho, y sin el pico de energia en el medio
    right_acorr = autocorr .* (lag > 1);
    
    [maxvalue, idx] = max(right_acorr);
    
    pitch = get_pitch_hertz((idx - m_ceros), fm);       
    
    return;

endfunction

# Hace el analisis por estimacion en el Cepstrum

function [ pitch ] = pitch_cepstrum(S, fm)

    y = fft(S);
    c = ifft(log(abs(y)));
    
    N = length(c);
    
    # Al ser simetrica, tomamos la primera mitad
    
    N_2 = floor(N/2);
    
    c_sim = c(1 : N_2);
    
    # Mido el pico luego de los 2 primeros msec (500Hz en adelante)
    # n * Tm = msec -> n = msec / Tm = msec * fm
    
    msec = 2e-3;
    start_here = msec * fm;
    
    c_considerar = c_sim(start_here : length(c_sim));
    
    # Ahora tomo el valor del pico mas alto (el segundo pico en realidad)
    [maxvalue, idx] = max(c_considerar);
    
    pitch = get_pitch_hertz((idx + start_here), fm);
    
    return;

endfunction

# Funcion base, le paso una senal, de voz retorna las estimaciones de pitch y muestra grafica
# La uso para llamarla varias veces con senales contaminadas con ruido

function [pitch_a, pitch_c] = analizar_pitchs(voice, fm, plotear = true)

    Tm = 1/fm;

    N = length(voice);

    tiempo = 0 : Tm : N * Tm - Tm;

    # Ventana de Hamming
    a0 = 0.53836;
    a1 = 0.46164;

    # Tamano de ventana en muestras (Tm * msec)
    msec = 40e-3;
    h_size = fm * msec;

    n = 0 : h_size - 1;
        
    v_hamming = a0 - a1 * cos((2 * pi * n) / (N - 1));

    # Estimacion de pitch 

    for M = 1 : N / h_size

        # Corto en segmentos la senal

        muestras(M, :) = voice((h_size * M - h_size + 1) : (h_size * M));
        
        # Me fijo cuantas veces corta el eje x #
        
        corta(M) = count_cortes(muestras(M,:));
        
        # Booleano que separa las sordas de las sonoras (1: sonoro, 0: sordo)
        
        max_frec_admitida = 90;
        min_ener_admitida = 0.1;
        
        if ( corta(M) > max_frec_admitida || max(xcorr(muestras(M, :))) < min_ener_admitida)        
            booleano(M) = 0;            
        else 
            booleano(M) = 1;       
        endif  
        
        # Hago las estimaciones si es sonora
        
        if (booleano(M))
        
            pitch_a(M) = pitch_autocorr(muestras(M, :), fm);            
            pitch_c(M) = pitch_cepstrum(muestras(M, :), fm);
        
        else 
            
            pitch_c(M) = pitch_a(M) = 0;
        
        endif                          
        
    endfor

    # Muestro una grafica 3D con ambas estimaciones de pitch (azul cepstrum, rojo autocorrelacion)

    N = length(pitch_a);    
    x = 0 : N - 1;
    
    if (plotear)
        clf; 
        stem3(x, zeros(1, N), pitch_c, 'b'); 
        hold on; 
        stem3(x, ones(1, N), pitch_a, 'r');
        hold off;
    endif
    
    return;
    
endfunction

# Le pasamos una senial, su fm, y una cantidad de ruido en db, devuelve la senial contaminada

function [ contaminada ] = add_noise(senial, fm, db)
    
    Tm = 1/fm;
    
    ini = 0;
    fin = length(senial) * Tm;

    t = ini : Tm : fin - Tm;
    N = length(t);
    
    var_ruido = 0.1;
    ruido = -var_ruido + rand(1, length(t)) * (var_ruido * 2);

    potencia_senial = 1/N * sum(senial.^2);
    potencia_ruido = 1/N * sum(ruido.^2);
    
    alpha = sqrt(potencia_senial / ( potencia_ruido * 10^(db / 10)));
    contaminada = senial + ruido * alpha;

    return;

endfunction

##################################################################################################
# SCRIPT

# Como se llama el mar que bana a Valencia?
voice = load("sent.txt")';

fm = 8000;

analizar_pitchs(voice, fm, false);

# Analicemos los casos con ruido

voice_0db = add_noise(voice, fm, 0);
voice_20db = add_noise(voice, fm, 20);
voice_50db = add_noise(voice, fm, 50);

analizar_pitchs(voice_0db, fm);
