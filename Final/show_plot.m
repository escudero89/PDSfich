#! /usr/bin/octave -qf


function [dt] = show_plot( mat, sound, dx1, dy1, dx2, dy2, width, large)

    dmic = [(dx1 + dx2)/2, (dy1 + dy2)/2];

    d = abs(dx2 - dx1) + abs(dy2 - dy1);

    [dE] = delta_tiempo(mat, sound);
    [alpha] = get_angle(dE, d)
    
    x = dmic(1) : 0.001 : width;
    y = tan(pi/2 + alpha) * (x - dmic(1)) + dmic(2);
    
    clf;
    hold on;
        plot(dmic(1), dmic(2), 'x');
        plot(dx1, dy1, 'ro');
        plot(dx2, dy2, 'bo');
        
        plot(x, y, 'm');
    hold off;
    
    xlim([0 width]);
    ylim([0 large]);

endfunction
