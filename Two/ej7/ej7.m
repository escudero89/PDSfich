pi;

clear all;

fid = fopen('te.txt');
A = fscanf(fid, '%f');
fclose(fid);

d1 = A(16000 : 22000);
d2 = A(29000 : 35000);
d3 = A(39000 : 45000);
d4 = A(48000 : 54000);
d5 = A(58000 : 64000);
d6 = A(69000 : 75000);
d7 = A(80000 : 86000);

d =	[A(16000 : 22000)';
A(29000 : 35000)';
A(39000 : 45000)';
A(48000 : 54000)';
A(58000 : 64000)';
A(69000 : 75000)';
A(80000 : 86000)'];

fm = 11025;
T = 1/fm;
t = 0 : length(d1) - 1;
t = (t * T)';

frec = [697 770 852 941 1209 1336 1447]';

% Armamos las bases
gfase = 200;
for k = 1 : 7
	maxRow= -100 * ones(1,4);
	maxCol= -100 * ones(1,3);
	
	for fase = [0:gfase*2-1]*pi/gfase %hasta 2pi
		
		for i = 1 : length(frec)
			bases(i,:) = sin(2*pi*frec(i)*t + fase);
			bases(i,:) /= norm(bases(i,:));
		end

		for i = 1 : length(frec)
			compd1(i) = dot(d(k,:), bases(i, :));% / norm(bases(i,:))^2;
		end
		
		if(max(maxRow) < max(compd1(1:4)))
			maxRow(1:4)=compd1(1:4);
			maxFaseR(k) = fase;
		endif
		
		if(max(maxCol) < max(compd1(5:7)))
			maxCol(1:3)=compd1(5:7);
			maxFaseC(k) = fase;
		endif
	
	endfor
	%disp(max(maxRow));
	%disp(max(maxCol));

	matriz = ["1" "4" "7" "*" ; "2" "5" "8" "0" ; "3" "6" "9" "#"]';

	[buff,resultado] = max(maxRow);
	[buff,resultado2] = max(maxCol);

	mostrar(k) = matriz(resultado,resultado2);
	compd1(1:7) = [maxRow maxCol];

endfor
mostrar
%bar(compd1);