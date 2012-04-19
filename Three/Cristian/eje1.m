#! /usr/bin/octave -qf
1;

# Funcion basica que te devuelve la transformada acomodada
function [fou] = get_fourier(senial)
    
    N = length(senial);
        
    fou = fftshift(fft(senial)); # la transforma y luego la acomoda
    
endfunction

# Retorno un vector de phi para hacer el espectro de fase
function [fase] = get_fase(senial_transf)

    fase = arg(senial_transf);
    #fase = atan(imag(senial_transf) ./ real(senial_transf));

endfunction

# Generamos la senial pedida:

ini = 0;
fin = 1;

fm = 1000;
T = 1/fm;

t = ini : T : fin - T;

f1 = 10;
f2 = 20;

s_t = sin(2 * pi * f1 * t) + 4 * sin(2 * pi * f2 * t);

# Parte I:

# Calculamos la TDF s_k y la mostramos

s_k = get_fourier(s_t);

# Vemos si se cumple lo de Parseval

if sum(s_t.^2) == 1/fm*sum(abs(s_k).^2)
    disp "Se cumple la relacion de Parseval."
else
    disp "No se cumple la relacion de Parseval."
endif

# Fin Parte I. Comienzo Parte II:

# Le sumamos un 4 y vemos que frutea en la grafica

s_t_uno = s_t .+ 4;

s_k_uno = get_fourier(s_t_uno);

# Le modificamos la frecuencia f2 y vemos los cambios dps

f2_nueva = 11;

s_t_f2 = sin(2 * pi * f1 * t) + 4 * sin(2 * pi * f2_nueva * t);

s_k_f2 = get_fourier(s_t_f2);


# Graficamos todo. Si queremos fase o magnitud modificar booleano

magnitud = 0;

clf; # borramos todo lo que hay ploteado y a la bosta

hold on;

if magnitud == true

    disp "Espectros de Magnitud"

    stem(abs(s_k_uno), 'g');
    
    stem(abs(s_k), 'r');    

else

    disp "Espectros de Fases"

    plot(get_fase(s_k), 'r');

    plot(get_fase(s_k_uno), 'g');        

    plot(get_fase(s_k_f2), 'b');   
    
endif

hold off;

