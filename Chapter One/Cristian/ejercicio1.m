a=1;

fm = 100;
ini = -3;
fin = 3;

T = 1/fm;
t = ini : T : fin - T;

Y_sin = sin(2 *pi*t);

# SINC

Y_sinc = sin(2*pi*t)./(2*pi*t);

for i = 1 : length(t)
    if abs(t(i)) < 1e-5
        index_cero = i;
        Y_sinc(index_cero) = 1;
    endif
endfor

# ENDSINC

# CUADRADA

fm_cuadrada = 1;
T_cuadrada = 1/fm_cuadrada;
t_cuadrada = ini : T_cuadrada : fin - T_cuadrada;

Y_cuadrada = ones(1, length(t));

flag = false;
for i = 1 : length(t_cuadrada)
    if flag == true
        Y_cuadrada((i-1)*fm : i*fm) = 0;
    endif
    flag = !flag;       
endfor

# ENDCUADRADA

# TRIANGULAR

rate_of_change = 1/fm;

Y_triangular(1) = 1;

for i = 2 : length(t)
    if abs(Y_triangular(i-1)) > 1
        rate_of_change = -rate_of_change;
    endif    
    Y_triangular(i) = Y_triangular(i-1) - rate_of_change;    
endfor

# ENDTRIANGULAR

# ONDA DIRAC

Y_dirac = zeros(1, length(t));
Y_dirac(index_cero) = 1;

# END ONDA DIRAC

# ALEATORIO

Y_aleatorio = rand(1, length(t));

# END ALEATORIO

plot(t, Y_sin, 'b', t, Y_sinc, 'r', t, Y_cuadrada, 'g', t, Y_triangular, 'k', t, Y_dirac, 'm');
#plot(t, Y_aleatorio);

