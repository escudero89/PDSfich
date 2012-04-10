1;

ini = 0;
fin = 2;
fm = 100;

T = 1/fm;
t = ini : T : fin - T;

for f = 1 : 10
    sins(f) = sin(2*pi*f*t);
endfor
