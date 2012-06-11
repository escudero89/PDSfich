#! /usr/bin/octave -qf
1;
clear all;

# Variables iniciales
fm = 10000;

normalizar = fm / 2;

Ws1 = 2300 / normalizar;
Wp1 = 2500 / normalizar;
Wp2 = 3000 / normalizar;
Ws2 = 3200 / normalizar;

Rp = 0.7; #db
Rs = 55; #db

# Calculamos el orden y el cutoff 
[n, Wc] = buttord([Wp1, Wp2], [Ws1, Ws2], Rp, Rs);

# Generamos los coeficientes del filtro
[b,a] = butter(n, Wc);

freqz(b,a,fm/2);

