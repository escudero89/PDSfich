#! /usr/bin/octave -qf
1;

# Leo el archivo

fid = load("te.txt");

fid = fid';

# Busco donde pega saltos copados de energia

here = zeros(1, length(fid));

for i = 1 : 2 : length(fid)
    energy = sum(fid(i)^2 + fid(i + 1)^2);
    
    if (energy > 1.2)
        here(i) = energy;
    endif    
endfor

%hold on;
%plot(fid, 'r');

%stem(here, 'g');
%hold off;

# Estuve demasiado jodiendo con el coso automatico de corte, asi que a la bosta

# Elijo ojimetro los lugares

step = 5000;
pos = [16 30 39 48 58 70 80] * 1000;

frag = [   
    fid(pos(1) : pos(1) + step);
    fid(pos(2) : pos(2) + step);
    fid(pos(3) : pos(3) + step);
    fid(pos(4) : pos(4) + step);
    fid(pos(5) : pos(5) + step);
    fid(pos(6) : pos(6) + step);
    fid(pos(7) : pos(7) + step)
];

# El muestreo es de 11025 Hz, como desconozco, hago la cosa rara de abajo

fm = 11025;
T = 1/fm;

t = 0 : T : (length(fid) - 1)*T;

# La matriz de valores es

mcol = [ 1209 1336 1447 ]';
mrow = [ 697 770 852 941 ]';


sinsr = sin(2 * pi * mrow * t(1 : step + 1));

sinsc_base = 2 * pi * mcol * t(1 : step + 1);

dots = zeros(1, length(frag(1,:)));

w = 1;

for phi = [0 : 0.1 : pi]
    sinsc = sin(sinsc_base .+ phi);
    
    for j = 1 : size(sinsc)(1)
        dots(j) = dot(frag(1, :), sinsc(j, :));
    endfor
    all_dots(w) = max(dots);
    
    w += 1;
    
endfor   
