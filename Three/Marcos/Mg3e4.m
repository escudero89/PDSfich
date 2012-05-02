1;
% Inciso 1
[t C] = m_cuadrada(0,1,4,100,0);
N1 = length(C);

% Inciso 2
Cadd = zeros(1,N1);
C = [C Cadd];
t2 = [0:0.01:2-0.01];
%plot(t2,C);

% Inciso 3
Ctransf = fftshift(fft(C));
stem(abs(Ctransf)/(2*N1));



