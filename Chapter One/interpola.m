function [xi] = interp_e(ini, fin, x, fr_i)
T = 1 / fr_i;
t = ini : T : fin - T;
for n = 1 : length(t)
   



function [y] = escalon(x)
if x > 0 & x < 1
   y = 1;
else % else
   y = 0;