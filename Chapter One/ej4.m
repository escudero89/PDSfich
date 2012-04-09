aaa=1;


[t,y] = m_sin(0, 2, 129, 4000, 0);
stem(t,y);


%En la figura ploteada parece que se obtiene una senoidal de 1hz
%Suceden cosas similares con otros numeros tales que
%el modulo de 4000 por ellos es un numero bajo:
%Algunos de ellos son:
%[3 31 43 93 129 1333 3999] mod = 1
%[1999 3998] mod  = 2
%[7 571 3997] mod = 3
%Se obtienen asi

a=0:4000;
y=mod(4000,a);
M1=[];
for(i=1:length(a))
	if(y(i)==1)
	M1=[M1,i-1];
	endif
endfor
disp(M1);



%En este ejemplo puede observarse mejor el fenomeno
%Graficamos una senoidal de frecuencia 10hz y fm = 9hz


[t1,y1] = m_sin(0, 2, 1000, 10, 0);
[t,y] = m_sin(0, 2, 7, 10, 0);

plot(t1,y1,'g');
hold on;
stem(t,y);
hold off;
