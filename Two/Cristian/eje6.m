1;

# Inicializo variables

ini = 0;
fin = 2;
fm = 100;

T = 1/fm;
t = ini : T : fin - T;

# Inciso (a) -----------------------------------------------------------------#

full_sins = zeros(1, length(t));
alpha = [5 8 13 23 41 42 7 33 12 2];

# Genero las ondas senoidales y la union de ellas

frecuencias_base = [1 2 3 4 5 6 7 8 9 10];

for f = 1 : 10
    sins(f, :) = sin(2*pi*frecuencias_base(f)*t);
    
    full_sins +=  sins(f, :) * alpha(f);
endfor

# Mido grado de parecidos (producto punto) y lo muestro

for f = 1 : 10
    parecidos(f) = sum(sins(f,:) .* full_sins) / dot(sins(f, :), sins(f, :));
endfor

# Constante de proporcionalidad:
%alfa = norm(sins(1,:))^2;

%bar(parecidos);

# Inciso (b) -----------------------------------------------------------------#

# Nuevo grupo de ondas senoidales, con phi desfasado

phi = pi * [0.2 : 0.2 : 2];

full_sins_phi = zeros(1, length(t));

for f = 1 : 10
    sins_phi(f, :) = sin(2*pi*f*t + phi(f));
    
    full_sins_phi += alpha(f) * sins_phi(f, :);
endfor

# Vuelvo a medir grado de parecidos

for f = 1 : 10
    parecidos_phi(f) = sum(sins_phi(f,:) .* full_sins) / dot(sins(f, :), sins(f, :));
endfor

# Mi constante de proporcionionalidad va a estar dada por el cos(phi)
alfa_phi = cos(phi);

bar(parecidos_phi ./ alfa_phi);

# Inciso (c) -----------------------------------------------------------------#

# Creamos una senial cuadrada de 5,5 Hz
f_square = 5.5;
s_square = sign(sin(2*pi*f_square*t));

for f = 1 : 10
	parecidos_square(f) = sum(sins(f,:) .* s_square);
endfor

%bar(parecidos_square);

% La onda cuadrada de frecuencia 5.5 es ortogonal a
% los senos de frecuencias 1, 2, ..., 10. Creemos que
% es asi porque una onda cuadrada esta formada por 
% una suma de senos de frecuencias f, 3f, 5f, ... donde
% f es la frecuencia de la onda cuadrada. En este caso,
% ninguno de los senos es multiplo de 5.5.
