1;

ini = 0;
fin = 1;
fm = 1000;
T = 1/fm;

t = ini : T : fin - T;
N = length(t);

f1 = 10;
f2 = 20;
s_t = sin(2*pi*f1*t+pi/3) + 4*sin(2*pi*f2*t);

%plot(t, s_t);

s_f = fft(s_t);
%s_f2 = [s_f(N/2+1 : N) s_f(1 : N/2)];

for n = 1 : N
	reconstruida(n) = 0;
	for k = 1 : N
		reconstruida(n) += s_f2(k) * e^(j*2*pi*(k-1)*n/N);
	end
end


%stem(abs(imag([s_f(n/2+1 : n) s_f(1 : n/2)])));

% Aparentemente, la fft devuelve un vector de numeros complejos
% en los que la parte real es la fase y la parte imaginaria es
% la magnitud (??)