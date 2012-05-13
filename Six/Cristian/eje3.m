#! /usr/bin/octave -qf
1;

N = 40;

for k = 1 : N
    z = e^(j*(2*pi*k/N));
    fou(k) = (10*z^2-10*z+10)/(10*z^2-7*z+1);
endfor

x = [0 0 0 0 0 0 0 1 zeros(1,N-10)];
y = [0 0 0];

for n = 3 : length(x)
    y(n) = x(n) - x(n-1) + x(n-2) + 1/10* (7 * y(n-1) - y(n-2));
endfor

fourier = abs(ifft(fou));

#[N M] = freqz([10 -10 10], [10 -7 1], N,"whole");

plot(fourier,'b', y,'r');
