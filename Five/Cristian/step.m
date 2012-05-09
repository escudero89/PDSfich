#! /usr/bin/octave -qf

function [ret] = step(S, signal=false)
    
    # Función unitaria de Heaviside o escalon unitario
    # Le paso un valor entre -inf a inf y retorna el valor escalonado
    
    if (signal == false)
    
        ret = 0;
        
        if (S > 0)
            ret = 1;
        endif                
    
    else
    
        ret = S > 0; # [-1 0 1 ] => [ 0 0 1 ] 
    
    endif
    
endfunction
