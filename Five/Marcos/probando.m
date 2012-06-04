1;

xEntrada = [0 0 1 0.5 2 1];
x = xEntrada;
n = length(x)
for k=3:n
S(k) = 3*x(k) + 2*x(k-1) + x(k-2);
end

Salida = S;

xDirac = [0 0 1 0 0 0];
x = xDirac;
n = length(x)
for k=3:n
S(k) = 3*x(k) + 2*x(k-1) + x(k-2);
end

RespImp = S;

C = conv(RespImp, xEntrada);


hold on;
stem([1:7],RespImp,'r');
stem(Salida);
plot(1:length(C),C,'g');
hold off;