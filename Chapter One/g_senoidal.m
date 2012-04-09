function[t,y] = g_senoidal(tini,tfin,f,fi,fm)
paso = 1/fm;
t = tini:paso:tfin-paso;
y = sin(2*pi*f*t+fi);

plot(t,y);