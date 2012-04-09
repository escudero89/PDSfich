aaa=1;
hold off;
[t2,y2] = g_senoidal(0,1,5,0,100);

fm = 25;
[t,y] = g_senoidal(0,1,5,0,fm);



plot(t2,y2,'y'); %señal "real"
hold on;
plot(t,y,'g'); 	 	% ploteo con fm
stem(t,y);			% stem con fm
axis([0,1,-1,1]);
hold off;




