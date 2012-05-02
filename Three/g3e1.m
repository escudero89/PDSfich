clear all;
clc;

fm = 50;
Tm = 1/fm;
t = 0 : Tm : 0.73 - Tm;
N = length(t);
T = N*Tm;



% Inciso 3

%eje nuevo f;
Tfreq = 1/T;

%f = [ini : Tfreq : fin];

f1 = 10;
f2 = 20;
S1 = cos(2 * pi *f1 * t) + 4 * sin(2 * pi * f2 * t) + 7;

[F A] = shiftFourier(abs(fft(S1)),1/T);
stem(F,A);
%stem(f,abs(fftshift(fft(S1)))/length(t));