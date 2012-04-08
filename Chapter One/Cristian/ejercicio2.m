a=1;

fm = 100;
ini = -3;
fin = 3;

T = 1/fm;
t = ini : T : fin - T;

Y_sin = sin(2 *pi*t);

factor = 2;

# Expansion
Y_sin_exp = Y_sin * factor;

# Compresion
Y_sin_cmp = Y_sin * 1/factor;

# Inversion
Y_sin_inv = Y_sin * -1;

# Rectificacion
Y_sin_rct = Y_sin;
f_rct = 0.7;

for i = 1 : length(t)
    if Y_sin_rct(i) > f_rct
        Y_sin_rct(i) = f_rct;
    endif
    
    if Y_sin_rct(i) < -f_rct
        Y_sin_rct(i) = -f_rct;
    endif
endfor

# Traslacion
phi = 0.5 * pi;
Y_sin_trs = sin(2 * pi * t + phi);

# Cuantizacion

Y_sin_cnt = Y_sin_rct; # tomo la ya rectificada
N = 3;
H = 0.2;

for i = 1 : length(t)
    if Y_sin_cnt(i) < 0
        Y_sin_cnt(i) = 0;
    else
        Y_sin_cnt(i) = H*round(Y_sin_cnt(i)/H);
    endif
endfor

# Imprime todo

plot(t, Y_sin, 'k', t, Y_sin_exp, 'g', t, Y_sin_cmp, 'r', t, Y_sin_inv, 'm', t, Y_sin_rct, 'b', t, Y_sin_trs, 'c', t, Y_sin_cnt, 'pr');

