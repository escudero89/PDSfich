function [y_cuant] = m_cuantiza(y, ymin, ymax, H)
y_cuant = max ( y, ymin ); % acota abajo
y_cuant = min ( y_cuant, ymax); % acota arriba
y_cuant = H * floor( y_cuant / H ); % cuantiza
end