#! /usr/bin/octave -qf

function [ret] = convolucion(A, B)

    # Guardo en X la senial mas chica
    X = A;
    Y = B;

    if length(A) > length(B)
        X = B;
        Y = A;
    endif
    
    X_N = length(X);
    Y_N = length(Y);

    # Invierto Y
    for k = 1 : Y_N
        Y_inv(k) = Y(Y_N - k + 1);
    endfor

    # Le agrego tantos X-size de ceros a la izquierda y a la derecha:
    ceros = zeros(1, X_N - 1);

    X_conv = [ ceros X ceros ];
    X_conv_N = length(X_conv);
    
    # Tamanio de la convolucion
    limite = X_conv_N - Y_N + 1;
    
    # Recorremos X y vamos "convolucionando"    
    for h = 1 : limite
        ret(h) = sum(X_conv(h : h + Y_N - 1) .* Y_inv);
    endfor

endfunction
