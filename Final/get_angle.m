#! /usr/bin/octave -qf

# Le pasas el delta espacio, y el d de separacion entre microfonos.
# Te retorna el angulo al que esta la fuente de sonido.

function [alpha] = get_angle( dE, d, degree = true )

    Beta = asin(dE / d);

    x = d * cos(Beta);
    h = x/2 * sin(Beta);    
    f = d/2 - x/2 * cos(Beta);
    
    alpha = - pi/2 + atan(h / f);
    
    if ( degree )
        alpha = alpha * 180 / pi;
    endif
    
    return;
    
endfunction
