1;

A = [ 5 4 6 ];
B = [ 1 -7 2 ];

la = length(A);
lb = length(B);

Y1 = convolucion(A, B);
Y2 = conv(A, B);
Y3 = filter(A, 1, [B zeros(1, la - 1)]);

% No da vieja
Y4 = ifft(fft(A) .* [fft(B) zeros(1, abs(la - lb))]);

N = 2*lb - 1;
Y5 = real(ifft(fft([A zeros(1, N)]) .* fft([B zeros(1, N)])));