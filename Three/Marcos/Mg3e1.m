1;
clear all;
clc;
% EJERCICIO 1 %

fm = 1000; 		%Frecuencia de muestreo
T = 1/fm;		%Periodo de muestreo
t = 0:T:20-T;	%Tiempo discreto
N = length(t);	%Cantidad de muestras

f1 = 10;		%Frecuencia 1
f2 = 10.5;		%Frecuencia 2

S = sin(2*pi*f1*t) + 4 * sin(2*pi*f2*t) + 5; 	%Señal generada

X2 = fftshift(fft(S));		% TDF con un shifteo

f = (-fm/2:(fm/N):fm/2-(fm/N)); % Armamos el dominio frecuencial

%Ploteamos dominio frecuencial
figure(2)			
stem(f,abs(X2)/N);				
%-----------------------------




