1;
clc;
clear all;

% EJERCICIO 3 %

% Parametros
fm = 10; 		%Frecuencia de muestreo
T = 1/fm;		%Periodo de muestreo
t = 0:T:1;	%Tiempo discreto
N = length(t);	%Cantidad de muestras
k = 7; 			%Multiplo para la freq
f1 = (2*k*pi)/N;%Freq que cumple con Eq
f2 = 4;			%Freq que no cumple con Eq
disp(f1);
S1a = sin(t*f1);
S2a = sin(t*f2);

% S1b = [S1a S1a];
% S2b = [S2a S2a];
% tb = 0:T:2-T;

% S1c = sin(tb*f1);

stem(t,S1a,'b');
%hold on;
% figure(2);
% stem(tb,S1b,'b');
% figure(3);
% stem(tb,S1c,'r');


%hold off;