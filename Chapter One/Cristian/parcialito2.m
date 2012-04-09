1;

function [ret] = get_media(x)
    ret = sum(x)/length(x);
endfunction

function [ret] = get_varianza(x, media)
    ret = sum((x - media).^2)/length(x);
endfunction

function [ret] = get_estacionaria(x, media, varianza, erg = false)
    
    ret = true; # suponemos que si lo es    
    desvio = sqrt(varianza)
    
    for i = 1 : length(x(1,:))
        if abs(get_media(x(:,i)) - media) > 2*desvio # 95.4% de que caiga dentro
            ret = false;
            break;
        endif
    endfor   

endfunction

function [ret] = get_ergodicidad(x, media, desvio)    
    [ret] = get_estacionaria(x', media, desvio, true);      
endfunction

ini = 0;
fin = 10;
fm = 100;
T = 1/fm;

t = ini : T : fin - T;

x = [randn(1000, length(t)), rand(1000,length(t))];
x = rand(1000,length(t));

disp "Analizando..."

media = get_media(x(:,1));
varianza = get_varianza(x(:,1), media);
ret_est = get_estacionaria(x, media, varianza);

if (ret_est == true)
    disp "Es estacionaria."
    ret_erg = get_ergodicidad(x, media, varianza);
    if (ret_erg == true)
        disp "Es ergodica."
    else
        disp "No es ergodica."
    endif
else 
    disp "No estacionaria"
endif
    

#plot(t,x);
