#! /usr/bin/octave -qf
1;

# De la guia subida a internet


# Inicializamos seniales

ini = 0;
fin = 1;

fm = 10;
Tm = 1/fm;

n = ini : Tm : fin - Tm;

N = length(n);

omega_k = 2 * pi * n / N;
omega_k_mala = 2 * pi * n / N * .3;

phi_k_n = e.^(j * omega_k * N);
phi_k_n_mala = e.^(j * omega_k_mala * N);

# Concatenamos

phi_unida = [phi_k_n, phi_k_n_mala];

fin_2 = 2;
n_2 = ini : Tm : fin_2 - Tm;

omega_k_2 = 2 * pi * n_2 / N;
omega_k_mala_2 = 2 * pi * n_2 / N * .3;

phi_k_n_2 = e.^(j * omega_k_2 * N);
phi_k_n_mala_2 = e.^(j * omega_k_mala_2 * N);

# Graficamos

#stem(n, phi_k_n, 'g', n, phi_k_n_mala, 'r');
clf;
hold on;
stem3(n_2, real(phi_k_n_2), imag(phi_k_n_2), 'g');
stem3(n_2, real(phi_k_n_mala_2), imag(phi_k_n_mala_2), 'r');
stem3(n_2, real(phi_unida), imag(phi_unida), 'b');
hold off;

xlabel("tiempo");
ylabel("real");
zlabel("imaginario");

# La unica que cumple la condicion es phi_k_n y phi_k_n_2, porque su omega_k
# es multiplo entero de 2*pi.
