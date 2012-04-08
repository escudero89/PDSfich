a=1;

T = 0.1;
t = -6:T:6-T;
%normal	(azul)
y = sin(t);		

%comprimida (violeta)
y1= sin(2*t);	

%expandida (rojo)
y2= sin(0.5*t);	

%invertida (amarillo)
y3= sin(-t);	


%rectificada (verde)
for i=1:length(t)
	if sin(t(i))>=0.5
		y4(i)= 0.5;
		elseif sin(t(i))<-0.5
			y4(i) = -0.5;
			else
			y4(i)=sin(t(i));
	endif
endfor


%trasladada (celeste)
y5 = sin(t+1);

plot(t,y,'b',t,y1,'4',t,y2,'r',t,y3,'y',t,y4,'g',t,y5,'5');