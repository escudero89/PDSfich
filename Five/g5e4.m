1;

X_base = [ 1 2 -2 3 1 ];
H = [ 2 1 0.5 0 ];
Y = [ 1 7 3 -1 ];

X = [X_base];
for j = 1 : 19 
	X = [X X_base];
endfor

% Conmutativa
if (convolucion(X, H) == convolucion(H, X))
	disp "Cumple con propiedad conmutativa"
endif

% Asociativa
if (convolucion(X, convolucion(H, Y)) == convolucion(convolucion(X, H), Y))
	disp "Cumple con propiedad asociativa"
endif

% Distributiva con respecto a la suma
if (convolucion(X, H + Y) == convolucion(X, H) + convolucion(X, Y))
	disp "Cumple con propiedad distributiva"
endif