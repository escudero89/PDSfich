#! /usr/bin/octave -qf

# Le pasas el delta espacio, y el d de separacion entre microfonos.
# Te retorna el angulo al que esta la fuente de sonido.

function [alpha] = get_angle( dE, d, degree = true )

    alpha = asin(dE / d) * -1; 
	
	if ( degree )
        alpha = alpha * 180 / pi;
    endif
	
    return;
    
endfunction
