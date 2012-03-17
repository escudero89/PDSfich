function [y] = m_triangular(ini,fin,f,fm,fi)
T = 1/fm;
t = ini : T : fin - T;
y = f_triangular(t,f,fi);
plot(t, y);
axis([ini fin -2 2]);	

function [y] = f_triangular(t,f,fi)
t1 = t*4*f - fi; % Expansion y desplazamiento
t1 = t1 - 4 * ceil((t1 - 2) / 4); %Magia, pone a t entre -2 y 2
y = 1 - abs(t1);% triangular
end
   
   
   
	   



