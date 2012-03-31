function [t, y] = m_sin(ini, fin, fm, f, fi)
T = 1/fm;
t = ini : T : fin - T;
y = sin(2*pi*f*t + fi);