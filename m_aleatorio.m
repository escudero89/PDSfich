function [y] = m_aleatorio(ini,fin,fm)
T = 1/fm;
t = ini : T : fin - T;
y = f_aleatorio(t);
plot(t, y);
axis([ini fin -2 2]);	

function [y] = f_aleatorio(t)
y = rand(1,length(t))*2 - 1;
end