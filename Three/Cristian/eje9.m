#! /usr/bin/octave -qf
1;
clear all;

# De la guia subida a internet

# Leo los archivos

fid = load("merval1.txt");
fid2 = load("merval2.txt");

fid = fid';
fid2 = fid2';

# Obtenemos su transformada, y algunos valores locos que no se si uso dps

fm = 1;
Tm = 1/fm;
t = 0 : Tm : length(fid) - Tm;

N = length(t);

t2 = 0 : Tm : N*2 - Tm;

dF = fm / N;

fourier = fft(fid);

new_fourier = zeros(1, 2*N);

for fou = 1 : N
    new_fourier(fou * 2 - 1) = fourier(fou);        
endfor

t_fid = ifft(new_fourier);

# Graficamos

plotear = false;

clf;
hold on;
if (plotear == true)
    plot(t, fid, 'k');
    plot(t2, abs(t_fid), 'r');
    plot(t2, [fid2 0], 'g');
else    
    stem(abs(new_fourier), 'g');
    stem(abs(fourier), 'k');
endif
hold off;
