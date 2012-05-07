1;

X_base = [ 1 2 -2 3 1 ];
H_base = [ 2 1 0.5 ];

X = [X_base];
for j = 1 : 19 
	X = [X X_base];
endfor

Y = convolucion(X, H_base);

stem(Y); % Demostradooo (?)