% Muestreo de sinc
function y = m_sync(tini, tfin, fm)
	T = 1/fm;
	t = tini : T : tfin - T;
    
	y = sync(t);
	plot(t, y);
end    

% Funcion y = { 1, t = 0 ; sin(t)/t, t != 0 }
function y = sync(x)
	y = x;
	for i = 1 : length(x)
    	d = x(i);
    	if ( d == 0 )
        	y(i) = 1;
    	else
        	y(i) = sin(d)/d;
    	end
	end
end