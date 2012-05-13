#! /usr/bin/octave -qf

function [ret] = convol(X, Y, circular=false)
    
    A = X;
    B = Y;
    
    N = length(A);
    M = length(B);

    if (circular & !(N==M))        
        disp "Wrong length of signals. Both must be equal.";
        ret = [];
        return;
    endif

    if (N > M)
        A = Y;
        B = X;
        
        N = M;
        M = length(B);
    endif
    
    B_conv = [ zeros(1, N-1), B, zeros(1, N-1) ];
    
    for k = 1 : N
        A_inv(k) = A(N - k + 1);
    endfor   
    
    if (circular)
        lim_conv = M; # deben valer el mismo tamanio
    else 
        lim_conv = M + N - 1;        
    endif
    
    ret = zeros(1, lim_conv);    
        
    for k = 1 : lim_conv
        if (circular)       
            A_inv = shift(A_inv, 1);
            ret(k) = sum(A_inv .* B);
        else
            lim = k : N + k - 1;
            ret(k) += sum(A_inv .* B_conv(lim));
        endif
    endfor    

endfunction
