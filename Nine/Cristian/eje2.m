#! /usr/bin/octave -qf
1;
clear all;

# Calcula la cantidad de veces que la grafica corta al eje x
function [corta] = count_cortes(S)
    
    corta = 0;
    
    for l = 2 : length(S)
        # Da cero si son iguales, uno si son distintas
        corta += 0.5 * abs(sign(S(l)) - sign(S(l-1)));
    endfor

    return;
endfunction


# Le pasas una senal y su frec de muestre, y devuelve el segundo pico mas alto (pitch)
# y la autocorrelacion

function [ pitch ] = pitch_autocorr(S, fm)

    [ autocorr, lag ] = xcorr(S);
    
    # Traducimos el lag en valores de frecuencia
    
    lag_frec = 1 ./ (lag * 1/fm);
    
    # Cuento la cantidad de muestras que voy a ignorar

    m_ceros = runlength(lag_frec >= 50)(1);
    
    # Analizo el maximo dentro del rango humano        
    
    humano = autocorr .* (lag_frec >= 50 & lag_frec <= 400);
    
    [maxvalue, idx] = max(humano);
    
    old_pitch = idx - m_ceros;    
    pitch = 1 / (old_pitch * 1 / fm);

endfunction

# Hace el analisis por estimacion en el Cepstrum

function [ pitch ] = pitch_cepstrum(S, fm)

    y = fft(S);
    c = ifft(log(abs(y)));
    
    N = length(c);
    
    # Al ser simetrica, tomamos la primera mitad
    
    N_2 = floor(N/2);
    
    c_sim = c(1 : N_2);
    
    # fm / muestras => Voy desde 400 Hz en adelante
    
    mfrec_u = 400;    
    start_here = fm / mfrec_u;

    c_considerar = c_sim(start_here : length(c_sim));
    
    # Ahora tomo el valor del pico mas alto (el segundo pico en realidad)
    [maxvalue, idx] = max(c_considerar);
    
    old_pitch = idx + start_here;    
    pitch = 1 / (old_pitch * 1 / fm);
    
    return;

endfunction

# Funcion base, le paso una senal, de voz retorna las estimaciones de pitch y muestra grafica
# La uso para llamarla varias veces con senales contaminadas con ruido

function [pitch_a, pitch_c, booleano] = analizar_pitchs(voice, fm, booleano = [], plotear = false)

    Tm = 1/fm;

    N = length(voice);

    tiempo = 0 : Tm : N * Tm - Tm;

    if (length(booleano) == 0)
        no_tengo_booleano = true;
    else 
        no_tengo_booleano = false;
    endif

    # Ventana de Hamming
    a0 = 0.53836;
    a1 = 0.46164;

    # Tamano de ventana en muestras (Tm * msec)
    msec = 30e-3;
    h_size = fm * msec;

    n = 0 : h_size - 1;
        
    v_hamming = a0 - a1 * cos((2 * pi * n) / (N - 1));

    # Estimacion de pitch 
    cortados = []; pegado = [];
    for M = 1 : N / h_size

        # Corto en segmentos la senal

        muestras(M, :) = voice((h_size * M - h_size + 1) : (h_size * M));
        
        # Me fijo cuantas veces corta el eje x #
        
        corta(M) = count_cortes(muestras(M,:));
        cortados = [cortados corta(M)];
        pegado = [pegado max(xcorr(muestras(M, :)))];
        # Si tengo el booleano, ni me caliento

        if (no_tengo_booleano)

            # Booleano que separa las sordas de las sonoras (1: sonoro, 0: sordo)
            
            max_frec_admitida = 80;
            min_ener_admitida = 0.1;        
            
            if ( corta(M) > max_frec_admitida || max(xcorr(muestras(M, :))) < min_ener_admitida)        
                booleano(M) = 0;            
            else 
                booleano(M) = 1;       
            endif  
        
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

[ pitch_a(1, :), pitch_c(1, :), booleano ] =analizar_pitchs(voice, fm);

# Analicemos los casos con ruido

voice_0db = add_noise(voice, fm, 0);
voice_20db = add_noise(voice, fm, 20);
voice_50db = add_noise(voice, fm, 50);

[pitch_a(2, :), pitch_c(2, :)] = analizar_pitchs(voice_50db, fm, booleano);
[pitch_a(3, :), pitch_c(3, :)] = analizar_pitchs(voice_20db, fm, booleano);
[pitch_a(4, :), pitch_c(4, :)] = analizar_pitchs(voice_0db, fm, booleano);

x = 1 : length(pitch_a);
N = length(x);

clf;

subplot(211);
hold on;
stem(x + N*0, pitch_a(1,:), 'r');
stem(x + N*1, pitch_a(2,:), 'r');
stem(x + N*2, pitch_a(3,:), 'r');
stem(x + N*3, pitch_a(4,:), 'r');
legend("Autocorrelacion");
ylabel('f [Hz]'); grid();
ylim([50, 400]);
hold off;

title("Comparacion de estimaciones de pitch de una senal.");

subplot(2, 1, 2);
hold on;
stem(x + N*0, pitch_c(1,:), 'b');
stem(x + N*1, pitch_c(2,:), 'b');
stem(x + N*2, pitch_c(3,:), 'b');
stem(x + N*3, pitch_c(4,:), 'b');
legend("Coeficientes Espectrales");
ylabel('f [Hz]'); grid();
ylim([50, 400]);
hold off;
