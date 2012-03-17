function [y] = m_dirac(ini,fin,f,fm,fi)
T = 1/fm;
t = ini : T : fin - T;

plot(t, y);
axis([ini fin -2 2]);	

function [y] = f_dirac(t,f,fi)
