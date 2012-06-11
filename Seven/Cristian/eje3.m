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
[n_butt, Wc_butt] = buttord([Wp1, Wp2], [Ws1, Ws2], Rp, Rs);

[n_cheb1, Wc_cheb1] = cheb1ord([Wp1, Wp2], [Ws1, Ws2], Rp, Rs);
[n_cheb2, Wc_cheb2] = cheb2ord([Wp1, Wp2], [Ws1, Ws2], Rp, Rs);

[n_ellip, Wc_ellip] = ellipord([Wp1, Wp2], [Ws1, Ws2], Rp, Rs);

# Divido el ordne por dos por wtf
n_butt = ceil(n_butt/2);

# Generamos los coeficientes del filtro
[b_butt, a_butt] = butter(n_butt, Wc_butt);

[b_cheb1, a_cheb1] = cheb(n_cheb1, Wc_cheb1);
[b_cheb2, a_cheb2] = cheb(n_cheb2, Wc_cheb2);

[b_ellip, a_ellip] = ellip(n_ellip, Wc_ellip);

clf;
hold on;
plot(abs(freqz(b_butt, a_butt, fm/2)));


hold off;
