1;

% (1 + C4 * T + R3 + R5) y[n]=
%		T(C2 * C2 * R5) x[n] - T(C2 * C2 * R5) x[n - 1] + ((R3 + R5) * T + 2)
%			* y[n - 1] - y[n - 2]

R1 = 1100;
C2 = 1e-6;
R3 = 2200;
C4 = 2e-6;
R5 = 1000;

ini = -1;
fin = 1;
fm = 100;
Tm = 1/fm;

t = ini : Tm : fin - Tm;
N = length(t);

dirac = zeros(1, N);
dirac(1001) = 1;

dirac = (t > 0);

# EULER:
T = 100;

A0 = (1 + C4 * T + R3 + R5);
A1 = ((R3 + R5) * T + 2);
A2 = -1;

B0 = B1 = T * (C2 * C2 * R5);

x = dirac;
y = [ 0 0 0 ];

for n = 3 : N
	y(n) = 1/A0 * (B0 * x(n) + B1 * x(n - 1) + A1 * y(n - 1) + A2 * y(n - 2));
endfor