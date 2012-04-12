#! /usr/bin/octave -qf
1;

# Un espacio vectorial de seniales senoidales esta dado matematicamente por:
# Ss = {x/x(t) = A sin(2*pi*f*t + phi)

# Bueno, a ver, la onda es plotear dos senos, luego me fijo si la suma de ellos
# tambien es un seno a ojimetro :v.

f = 1;
t = 0 : 0.01 : 2 - 0.01;

phi = [0 pi/3];
A = [1 3];

y1 = A(1)*sin(2*pi*f*t + phi(1));
y2 = A(2)*sin(2*pi*f*t + phi(2));

plot(t, y1, 'r', t, y2, 'g', t, y1 .+ y2, 'c');
