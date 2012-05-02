function [t,y] = m_cuadrada(ini,fin,f,fm,fi)
T = 1/fm;
t = ini : T : fin - T;
y = f_cuadrada(t,f,fi);
%plot(t, y);

function [y] = f_cuadrada(t,f,fi)
t1 = t * 2 * f - fi; % para permitir cambios de frecuencia y desplazamientos
y = mod( floor( t1 ), 2 ); % definicion de la funcion cuadrada, con frecuencia de 1/2; retorna 0 o 1
% Para que el resultado este entre -1, 1:
y = -2 * y + 1; % esto en vez de un if para trabajar con todos los elementos del vector y que de -1 o 1
end
   
   
   
	   



