function [f,A] = shiftFourier (fourier, df)
	N = length(fourier);
	f = [0:N-1] * df; % df = 1/T0
	
	A = fftshift(fourier);
	f = fftshift(f);
	
	for i=1:N-1
		if(f(i)== 0)
			break;
		endif
		f(i) -= N * df;
	endfor
endfunction
