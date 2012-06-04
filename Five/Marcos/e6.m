1;
clear;
% Definiciones
fm = 100;
T = 1/fm;
t = -5:T:5-T;

for i= 1:1000
	if (t(i)<0)
		U(i) = 0;
	else
		U(i) = 1;
	end
end


A = 0.5;

% Respuesta a los impulsos
h_a = sin(8 * t);
h_b = (A.^t) .* U;

% Entrada
b = 1;
x1 = zeros(1,length(t));
x1(501) = 1;
x2 = zeros(1,length(t));
x2(500) = 1;
x = x1 - b*x2;

w = conv(x,h_a);
w = w(1:1000);
y = conv(w,h_b);
y = y(1:1000);

stem(y);

