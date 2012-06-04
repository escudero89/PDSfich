1;
n = 50;
EU = ones(1,n);
dirac = zeros(1,n);
dirac(1) = 1;

% RESPUESTA A ESCALON UNITARIO UTILIZANDO EL SISTEMA
if 1
X = EU;
X(1:2) = [0 0];
RtaEU = [0 0];
for k=3:n
RtaEU(k) =(X(k) + X(k-1) - X(k-2))/5;
%RtaEU(k) = (X(k) - 2*X(k-1) + X(k-2) + 4*RtaEU(k-1) - 5*RtaEU(k-2))/6;
end
R1 = RtaEU;
clf;
hold on;
%stem([1:50],R1,'r');
end

% RESPUESTA A ESCALON UNITARIO UTILIZANDO CONVOLUCIÓN
if 1
RtaImp = [0 0];
X = [0 0 dirac(1:n-2)];

for k=3:n
RtaImp(k) = (X(k) + X(k-1) - X(k-2))/5;
%RtaImp(k) = (X(k) - 2*X(k-1) + X(k-2) + 4*RtaImp(k-1) - 5*RtaImp(k-2))/6;
end

R2 = conv(RtaImp, EU);
%stem([1:99],R2);
hold off
end
figure(1)
hold on;
stem([1:99],R2,'b');
stem([1:50],R1,'r');
hold off;

figure(2);
clf;
stem(RtaImp);
