1;
clc;
clear all;

% EJERCICIO 2 %

% Parametros
fm = 100; 		%Frecuencia de muestreo
T = 1/fm;		%Periodo de muestreo
t = 0:T:1-T;	%Tiempo discreto
N = length(t);	%Cantidad de muestras
f2 = 4;
f1 = 2;
f3 = 3.5;

% Generamos Señales
SS2 = sin(2*pi*t*f1); 			%Señal A
C2 = m_cuadrada(0,1,2,fm,0);	%Señal B
SS4 = sin(2*pi*t*f2);			%Señal C

% Analizamos Ortogonalidad
disp('Ortogonalidad en funciones');
dot(SS2,C2) 	% No Ortogonales
dot(SS2,SS4) 	% Ortogonales
dot(C2,SS4) 	% Ortogonales

% Calculamos Transformadas
T_SS2 = fftshift(fft(SS2));
T_C2 = fftshift(fft(C2));
T_SS4 = fftshift(fft(SS4));

% Analizamos Ortogonalidad en el Dominio Transformado
disp('Ortogonalidad en funciones transformadas');
dot(T_SS2 , T_C2) 	% No Ortogonales
dot(T_SS2 , T_SS4) 	% Ortogonales
dot(T_C2 , T_SS4) 	% Ortogonales

% Posible conclusion: 


%% Plot zone
%% hold on;
%% plot(t,SS2,'r');
%% plot(t,C2,'g');
%% plot(t,SS4,'b');
%% hold off;

