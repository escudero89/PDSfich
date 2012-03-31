function [vmedio, maximo, minimo, amplitud, energia, accion, pot_media, rms] = eje1(x)    
    vmedio = sum(x) / length(x);
    maximo = max(x);
    minimo = min(x);
        
    % Norma inf, 2, 1 respectivamente
    amplitud = max(abs(x));
    energia = sqrt(sum(x.^2));
    accion = sum(abs(x));
    
    pot_media = sum(abs(x).^2) / length(x);
    rms = sqrt(pot_media);    
endfunction
    
    
