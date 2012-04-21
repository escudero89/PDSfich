#! /usr/bin/octave -qf
1;
clear all;

# De la guia subida a internet

# Leo el archivo

fid = load("necg.txt");

fid = fid';

# Obtengo su transformada

fm = 360;
N = length(fid);

Tm = 1/fm;
t = 0 : Tm : (N*Tm) - Tm;

dF = fm/N;

[fourier, frec] = get_fourier(fid, dF);

# Guardamos la base
old_fourier = fourier;

# A lo negro eliminamos frecuencias de la banda 40 a 180

for f = 1 : length(frec)
    
    fr = abs(frec(f));
    
    if (fr >= 40 && fr <= 180)
        fourier(f) = 0;
    endif

endfor

# Antitransformo

nuevo_fid = real(ifft(fourier));

# Ploteo

plot_stem = false;

clf;

hold on;

if plot_stem == true
    stem(frec,abs(old_fourier), 'k');
    stem(frec,abs(fourier), 'g');
else
    plot(t, fid, 'k');
    plot(t, nuevo_fid, 'g');
endif    

hold off;

