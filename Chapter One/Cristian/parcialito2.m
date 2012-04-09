1;

function [ret] = get_media(x)
    ret = sum(x)/length(x);
endfunction

function [ret] = get_desvio(x, media)
    ret = sum((x - media).^2)/length(x);
endfunction

function [ret, media, desvio] = get_estacionaria(x, media = 0, desvio = 0, erg = false)
    
    ret = true; # suponemos que si lo es
    
    if (erg == false)
        media = get_media(x(:,1));
        desvio = get_desvio(x(:,1), media);
    endif
    
    for i = 1 : length(x(1,:))
        if abs(get_media(x(:,i))-media) > desvio
            ret = false;
            break;
        endif
    endfor   

endfunction

function [ret] = get_ergodicidad(x, media, desvio)    
    [ret] = get_estacionaria(x');      
endfunction

ini = 0;
fin = 10;
fm = 100;
T = 1/fm;

t = ini : T : fin - T;

x = randn(100, length(t));

disp "Analizando..."
[ret, media, desvio] = get_estacionaria(x);

if (ret == true)
    disp "Es estacionaria."
    ret_erg = get_ergodicidad(x, media, desvio, true);
    if (ret_erg == true)
        disp "Es ergodica."
    else
        disp "No es ergodica."
    endif
else 
    disp "No estacionaria"
endif
    

#plot(t,x);
