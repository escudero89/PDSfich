#! /usr/bin/octave -qf
1;

# De la guia subida a internet

# Verifica ortogonalidades entre dos seniales

function [prod_interno] = es_ortogonal(senial1, senial2)

    prod_interno = dot(senial1, senial2) / dot(senial2, senial2);   
    
    prod_interno = abs(prod_interno);
    
endfunction


# Inicializamos seniales

ini = 0;
fin = 1;

fm = 100;
Tm = 1/fm;

t = ini : Tm : fin - Tm;

f_senoidal = 4;
f_cuadrada = 2;
f_sen_disc = 3.5;

senoidal = sin(2 * pi * f_senoidal * t);
cuadrada = sign(sin(2 * pi * f_cuadrada * t));
sen_disc = sin(2 * pi * f_sen_disc * t);

# Verificamos ortogonalidad usando producto interno

disp "Productos internos:"

prod_senos = es_ortogonal(sen_disc, senoidal)
prod_sencu = es_ortogonal(senoidal, cuadrada)
prod_cuadi = es_ortogonal(cuadrada, sen_disc)

# No son ortogonales entre las ondas cuadradas y senoidales de distinta 
# frecuencia

dF = fm / length(t);

[senoidal_k, senoidal_f] = get_fourier(senoidal, dF);
[cuadrada_k, cuadrada_f] = get_fourier(cuadrada, dF);
[sen_disc_k, sen_disc_f] = get_fourier(sen_disc, dF);

fou_frec = senoidal_f;

# Todas las seniales tienen el mismo dominio de frecuencias igualmente

plotear = false;

if plotear == true
    plot(
        fou_frec, abs(senoidal_k), 'r', 
        fou_frec, abs(cuadrada_k), 'g', 
        fou_frec, abs(sen_disc_k), 'b'
    );
endif

disp "Productos internos en base de Fourier:"

prod_senos_k = es_ortogonal(sen_disc_k, senoidal_k)
prod_sencu_k = es_ortogonal(senoidal_k, cuadrada_k)
prod_cuadi_k = es_ortogonal(cuadrada_k, sen_disc_k)

# Vemos que los productos internos siguen siendo los mismos en otra base

# El producto interno entre una senoidal de 3.5 y una de 4 deberian 
# seguir siendo ortogonal.
