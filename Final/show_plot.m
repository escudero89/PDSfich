#! /usr/bin/octave -qf

function [dt] = show_plot( mat, sound, d1, d2, room )

    [ width, large, height ] = check_position(room);

    [dx1, dy1, dz1] = check_position(d1);
    [dx2, dy2, dz2] = check_position(d2);

    dmic = [(dx1 + dx2)/2, (dy1 + dy2)/2, (dz1 + dz2)/2];

    d = abs(dx2 - dx1) + abs(dy2 - dy1) + abs(dz2 - dz1);

    [dE] = delta_tiempo(mat, sound)
    [alpha] = get_angle(dE, d)
    
    x = dmic(1) : 0.001 : width;
    y = tan(pi/2 + alpha) * (x - dmic(1)) + dmic(2);
    z = ones(1, length(x)) * dmic(3);
    
    clf;
    hold on;
    
        if (height) # Si tiene el argumento z, lo plotea 3d
        
            plot3(dmic(1), dmic(2), dmic(3), 'x');
            plot3(dx1, dy1, dz1, 'ro');
            plot3(dx2, dy2, dz2, 'bo');
            
            plot3(x, y, z, 'g');
        
        else 
        
            plot(dmic(1), dmic(2), 'x');
            plot(dx1, dy1, 'ro');
            plot(dx2, dy2, 'bo');
            
            plot(x, y, 'g');
        
        endif
        
    hold off;
    
    xlim([0 width]);
    ylim([0 large]);
    zlim([0 height]);

endfunction


# Si tiene el tercer argumento, lo manda, sino le pone cero

function [x, y, z] = check_position(X)

    x = X(1);
    y = X(2);
    z = 0;

    if (length(X) > 2)
        z = X(3);
    endif

endfunction
