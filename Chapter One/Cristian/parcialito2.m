1;

function [ret] = get_media(x)
    ret = sum(x)/length(x);
endfunction

function [ret] = get_varianza(x, media)
    ret = sum((x - media).^2)/length(x);
endfunction

function [ret] = get_estacionaria(x)
    
    ret = true; # suponemos que si lo es        
       
    for i = 1 : length(x(1,:))
        media = get_media(x(:,i));
        varianza = get_varianza(x(:,i), media);
        desvio = sqrt(varianza);
        
        vec_sort = sort(abs(x(:,i) - media) > 2*desvio);
        # deja un vector ordenado de ceros y unos (estos son los que son mayores)                        
        run_vec_sort = runlength(vec_sort');
           
        if (run_vec_sort(1) / length(vec_sort)) > 95  # 95.4% de que caiga dentro
            ret = false;
            break;
        endif
    endfor   

endfunction

function [ret] = get_ergodicidad(x)    
    [ret] = get_estacionaria(x');      
endfunction

ini = 0;
fin = 10;
fm = 100;
T = 1/fm;

t = ini : T : fin - T;

x = [randn(1000, 500) , rand(1000, 500)];

disp "Analizando..."

ret_est = get_estacionaria(x);

if (ret_est == true)
    disp "Es estacionaria."
    ret_erg = get_ergodicidad(x);
    if (ret_erg == true)
        disp "Es ergodica."
    else
        disp "No es ergodica."
    endif
else 
    disp "No estacionaria"
endif
    

#plot(t,x);
