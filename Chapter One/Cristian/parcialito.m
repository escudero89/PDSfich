a=1;
# Realice el codigo para implementar una interpolacion de orden 1 de una
# senial x[n].

# Interpolador del tipo escalon
function [ret] = i_escalon(t)
    unos = 1 > t; # [-2,-1,0,1,2] => [1,1,1,0,0]
    ceros = 0 <= t; # [-2,-1,0,1,2] => [0,0,1,1,1]

    ret = unos & ceros; # [...] => [0,0,1,0,0]
endfunction

# Funcion que hace la interpolacion
function [t_out, x_out] = interpola(t_in, x_in, ini, fin, fm_s)
    T_s = 1 / fm_s;
    t_out = ini : T_s : fin - T_s;
    x_out = zeros(1,length(t_out));

    for n = 1 : length(t_out) 
        index = ceil(n/4);
        x_out += x_in(index) * i_escalon(t_out/T_s - n + 1);
    endfor

    # t_in = [1 2 3 4 5 6 7 8 9]
    # t_out = [0.2 0.4 0.6 0.8 1.0 … 8.8 9.0]
    # x_out(i) = Sumatoria(en n = length(t_in)   )
    # length(x_out) == length(t_out)
endfunction

# Variables iniciales
f = 1;
fm = 10;
T = 1/fm;
ini = 0;
fin = 3;

# Creamos [t,y]
t = ini : T : fin - T;
x = sin(2 * pi * t * f);

# Sobremuestreamos
fm_s = 4*fm;
[t_out, x_out] = interpola(t, y, ini, fin, fm_s);

stem(t, x, 'k');
hold on;
plot(t_out, x_out, 'g');
hold off;
