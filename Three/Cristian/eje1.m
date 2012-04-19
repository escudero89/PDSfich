#! /usr/bin/octave -qf
1;

# Funcion basica que te devuelve la transformada y acomodada
function [fou, fou_acom] = get_fourier(senial)
    
    N = length(senial);
    
    fou = fft(senial);
    fou_acom = [fou(1, N/2+1 : N), fou(1, 1 : N/2)];
    
endfunction

# Retorno un vector de phi para hacer el espectro de fase
function [fase] = get_fase(senial_transf)

    fase = atan( imag(senial_transf) ./ real(senial_transf));

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

[s_k, s_k_acomodado] = get_fourier(s_t);

# Vemos si se cumple lo de Parseval

if sum(s_t.^2) == 1/fm*sum(abs(s_k).^2)
    disp "Se cumple la relacion de Parseval."
else
    disp "No se cumple la relacion de Parseval."
endif

# Fin Parte I. Comienzo Parte II:

# Le sumamos un 4 y vemos que frutea en la grafica

s_t_uno = s_t .+ 4;

[s_k_uno, s_k_uno_acom] = get_fourier(s_t_uno);


# Graficamos todo. Si queremos fase o magnitud modificar booleano

magnitud = false;

hold on;

if magnitud == true

    disp "Espectros de Magnitud"

    plot(t, abs(s_k_acomodado), 'r');

    plot(t, abs(s_k_uno_acom), 'g');

else

    disp "Espectros de Fases"

    plot(t, get_fase(s_k_acomodado), 'r');

    plot(t, get_fase(s_k_uno_acom), 'g');        
    
endif

hold off;

