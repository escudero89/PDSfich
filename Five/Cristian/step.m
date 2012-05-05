#! /usr/bin/octave -qf

function [ret] = step(S)
    
    # Función unitaria de Heaviside o escalon unitario
    # Le paso un valor entre -inf a inf y retorna el valor escalonado
    
    ret = 0;
    
    if (S > 0)
        ret = 1;
    endif                
    
endfunction
