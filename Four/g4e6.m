1;
% Elegir 1 o 0 en alguno
dirac = 1;
unitario = 0;
if dirac == unitario
disp('Error')
break;
end

%-------------------------------
% Respuesta a DELTA DE DIRAC
%-------------------------------

if dirac 
X = [ 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0];
n = 1 : length(X);
N = length(n);

Y1 = [ X(1) X(2) ];
Y4 = [ X(1) X(2) ];
for k = 3 : N
	Y1(k) = X(k) + Y1(k - 2);
	Y4(k) = X(k) + 0.5 * Y4(k - 1) - 0.25 * Y4(k - 2);
endfor

Y2 = [ X(1) ];
Y3 = [ X(1) ];
Y5 = [ X(1) ];
for k = 2 : N
	Y2(k) = X(k) + 0.5 * X(k - 1);
	Y3(k) = X(k) + 2 * X(k - 1) + Y3(k - 1);
	Y5(k) = X(k) + X(k - 1) - Y5(k - 1);
endfor

z = ones(1, N);


clf;
hold on;

stem3(n, z*0, X, 'k');
stem3(n, z*1, Y1, 'r');
stem3(n, z*2, Y2, 'g');
stem3(n, z*3, Y3, 'b');
stem3(n, z*4, Y4, 'c');
stem3(n, z*5, Y5, 'm');

hold off;
end

%-------------------------------
% Respuesta a ESCALON UNITARIO
%-------------------------------
if unitario 
X = [ 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1];
n = 1 : length(X);
N = length(n);

Y1 = [ X(1) X(2) ];
Y4 = [ X(1) X(2) ];
for k = 3 : N
	Y1(k) = X(k) + Y1(k - 2);
	Y4(k) = X(k) + 0.5 * Y4(k - 1) - 0.25 * Y4(k - 2);
endfor

Y2 = [ X(1) ];
Y3 = [ X(1) ];
Y5 = [ X(1) ];
for k = 2 : N
	Y2(k) = X(k) + 0.5 * X(k - 1);
	Y3(k) = X(k) + 2 * X(k - 1) + Y3(k - 1);
	Y5(k) = X(k) + X(k - 1) - Y5(k - 1);
endfor

z = ones(1, N);


clf;
hold on;

stem3(n, z*0, X, 'k');
stem3(n, z*1, Y1, 'r');
stem3(n, z*2, Y2, 'g');
stem3(n, z*3, Y3, 'b');
stem3(n, z*4, Y4, 'c');
stem3(n, z*5, Y5, 'm');

hold off;
end

