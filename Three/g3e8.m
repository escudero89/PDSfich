1;

fm = 350;
Tm = 1/fm;
t = 0 : Tm : 1 - Tm;
N = length(t);
T = Tm*N;

f = 43528;
sn = 2 * sin(2*pi*f*t);
sk = fft(sn);
# El aliasing se manifiesta en la frecuencia siguiendo la relacion +-(|fm - f|%fm)
[magspecx, magspecy] = shiftFourier(abs(sk), 1/T);

stem(magspecx, magspecy/N);

# La relacion entre magnitud y amplitud, en senoidales, es el doble el segundo
