function [y] = m_dirac(ini,fin,fm,fi)
T = 1/fm;
t = ini : T : fin - T;
y = f_dirac(t, fi);

plot(t, y);
axis([ini fin -2 2]);
endfunction

function [y] = f_dirac(t,fi)
	y = zeros(1,length(t));
	
	for i = 1 : length(t)
		if abs(t(i) + fi) < 10e-5
			y(i) = 1;
			break;
		end
	end
	
	
endfunction