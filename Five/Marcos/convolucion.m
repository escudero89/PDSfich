function C = convolucion(v1,v2,lineal = true)
if(lineal)
	%% CONVOLUCION LINEAL %%
	% Llenamos con 0's para poder hacer la conv lineal
	n1=length(v1);
	n2=length(v2);
	v1 = [v1 zeros(1,n2-1)];
	v2 = [v2 zeros(1,n1-1)];
	% Transformamos
	V1=fft(v1);
	V2=fft(v2);
	% Hacemos producto en freq (que es igual a conv en el tiempo)		
	V3 = V1 .* V2;
	% Antitransformamos
	v3 = ifft(V3);
	C = v3;
	
else
	%% CONVOLUCION CIRCULAR %%
	if(length(v1) != length(v2))
		disp('No es posible aplicar CONVOLUCION CIRCULAR, length diferentes');
		return;
	endif
	V1=fft(v1);
	V2=fft(v2);
	V3 = V1 .* V2
	v3 = ifft(V3);
	C = v3;
endif

endfunction
